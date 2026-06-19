
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/audio/audio_engine_service.dart';
import 'package:myapp/data/song_data.dart';
import 'package:myapp/playback/playback_state.dart';

// The Riverpod provider for our playback controller.
final playbackControllerProvider = StateNotifierProvider<PlaybackController, PlaybackState>((ref) {
  return PlaybackController(ref);
});

class PlaybackController extends StateNotifier<PlaybackState> implements TickerProvider {
  final Ref _ref;
  Ticker? _ticker;
  Duration _lastTickTime = Duration.zero;

  // A private list of notes currently being played by the audio engine.
  final Set<int> _activeAudioNotes = {};

  PlaybackController(this._ref) : super(const PlaybackState());

  // --- Public API for UI Interaction ---

  void play() {
    if (state.status == PlaybackStatus.playing) return;
    state = state.copyWith(status: PlaybackStatus.playing);
    _startTicker();
  }

  void pause() {
    if (state.status == PlaybackStatus.paused) return;
    state = state.copyWith(status: PlaybackStatus.paused);
    _stopTicker();
    // When pausing, stop all currently playing notes to prevent them from hanging.
    _stopAllNotes();
  }

  void stop() {
    state = const PlaybackState(); // Reset to initial state
    _stopTicker();
    _stopAllNotes();
  }

  void seek(Duration newPosition) {
    state = state.copyWith(progress: newPosition);
    // After seeking, we need to re-evaluate which notes should be playing.
    _updateAudioEngine(newPosition);
  }

  void setSpeed(double newSpeed) {
    state = state.copyWith(speed: newSpeed);
  }

  void toggleLooping() {
    state = state.copyWith(isLooping: !state.isLooping);
  }

  void setLoopPoints(Duration start, Duration end) {
    state = state.copyWith(loopStart: start, loopEnd: end);
  }

  void setPracticeMode(PracticeMode mode) {
    state = state.copyWith(practiceMode: mode);
  }

  void setHandIsolation(HandIsolation isolation) {
    state = state.copyWith(handIsolation: isolation);
  }

  // --- Internal Ticker and Timeline Logic ---

  void _startTicker() {
    if (_ticker == null || !_ticker!.isActive) {
      _lastTickTime = Duration(microseconds: DateTime.now().microsecondsSinceEpoch);
      _ticker = createTicker(_onTick);
      _ticker!.start();
    }
  }

  void _stopTicker() {
    _ticker?.stop();
    _ticker?.dispose();
    _ticker = null;
  }

  void _onTick(Duration elapsed) {
    final now = DateTime.now().microsecondsSinceEpoch;
    final delta = Duration(microseconds: now) - _lastTickTime;
    _lastTickTime = Duration(microseconds: now);

    if (state.status == PlaybackStatus.playing) {
      final newProgress = state.progress + (delta * state.speed);
      _updateAudioEngine(newProgress);
      state = state.copyWith(progress: newProgress);

      // Handle A-B loop
      if (state.isLooping && state.loopEnd != null && state.progress >= state.loopEnd!) {
        seek(state.loopStart ?? Duration.zero);
      }
    }
  }

  // This is the core logic that syncs the audio engine with the timeline.
  void _updateAudioEngine(Duration currentProgress) {
    final audioEngine = _ref.read(audioEngineProvider.notifier);

    // Determine which notes should be playing based on current progress.
    final notesToPlay = <int>{};
    for (final note in placeholderSong) {
      final isNoteActive = currentProgress >= note.startTime && currentProgress < note.endTime;
      if (isNoteActive) {
        // Apply hand isolation rules.
        bool shouldPlay = true;
        if (state.handIsolation == HandIsolation.leftOnly && note.hand == NoteHand.right) {
          shouldPlay = false;
        }
        if (state.handIsolation == HandIsolation.rightOnly && note.hand == NoteHand.left) {
          shouldPlay = false;
        }
        if(shouldPlay){
            notesToPlay.add(note.noteNumber);
        }
      }
    }

    // Start notes that should be playing but aren't.
    final newNotes = notesToPlay.difference(_activeAudioNotes);
    for (final noteNumber in newNotes) {
      audioEngine.playNote(noteNumber);
      _activeAudioNotes.add(noteNumber);
    }

    // Stop notes that are playing but shouldn't be.
    final stoppedNotes = _activeAudioNotes.difference(notesToPlay);
    for (final noteNumber in stoppedNotes) {
      audioEngine.stopNote(noteNumber);
      _activeAudioNotes.remove(noteNumber);
    }
  }

  void _stopAllNotes() {
    final audioEngine = _ref.read(audioEngineProvider.notifier);
    for (final noteNumber in _activeAudioNotes) {
      audioEngine.stopNote(noteNumber);
    }
    _activeAudioNotes.clear();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
  
  @override
  void dispose() {
    _stopTicker();
    super.dispose();
  }
}
