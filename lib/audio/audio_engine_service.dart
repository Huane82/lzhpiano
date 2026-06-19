
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

// 1. Define the state for our audio engine
@immutable
class AudioEngineState {
  final bool isLoaded;
  final String? error;

  const AudioEngineState({this.isLoaded = false, this.error});

  AudioEngineState copyWith({bool? isLoaded, String? error}) {
    return AudioEngineState(
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
    );
  }
}

// 2. Create the StateNotifier
class AudioEngineService extends StateNotifier<AudioEngineState> {
  final Ref _ref;
  final List<AudioPlayer> _playerPool = [];
  final Map<int, AudioPlayer> _playingNotes = {};
  final AudioCache _audioCache = AudioCache(prefix: 'assets/audio/');
  final int _poolSize = 16;

  AudioEngineService(this._ref) : super(const AudioEngineState()) {
    _initialize();
  }

  void _initialize() async {
    // Initialize the player pool
    for (int i = 0; i < _poolSize; i++) {
      _playerPool.add(AudioPlayer());
    }
    // Begin loading samples immediately
    await loadSamples();
  }

  Future<void> loadSamples() async {
    if (state.isLoaded) return;

    try {
      debugPrint('Caching audio samples...');
      final filesToCache = List.generate(88, (i) => '${i + 1}.mp3');
      await _audioCache.loadAll(filesToCache);
      state = state.copyWith(isLoaded: true);
      debugPrint('All 88 audio samples cached successfully!');
    } catch (e) {
      debugPrint('Error caching audio samples: $e');
      state = state.copyWith(error: 'Failed to load piano samples. $e');
    }
  }

  AudioPlayer? _getAvailablePlayer() {
    try {
      return _playerPool.firstWhere((p) => p.state != PlayerState.playing);
    } catch (e) {
      // This can happen if all players are busy.
      // For now, we'll just reuse the first one.
      return _playerPool.first;
    }
  }

  void playNote(int noteNumber) {
    if (!state.isLoaded) return;
    stopNote(noteNumber, fromRestart: true);

    final player = _getAvailablePlayer();
    if (player != null) {
      player.play(AssetSource('$noteNumber.mp3'));
      _playingNotes[noteNumber] = player;
    }
  }

  void stopNote(int noteNumber, {bool fromRestart = false}) {
    final isSustainOn = _ref.read(sustainProvider);
    if (isSustainOn && !fromRestart) return;

    if (_playingNotes.containsKey(noteNumber)) {
      _playingNotes[noteNumber]?.pause();
      _playingNotes.remove(noteNumber);
    }
  }

  @override
  void dispose() {
    for (var player in _playerPool) {
      player.dispose();
    }
    debugPrint('All audio players disposed.');
    super.dispose();
  }
}

// 3. Create the StateNotifierProvider
final audioEngineProvider = StateNotifierProvider<AudioEngineService, AudioEngineState>((ref) {
  return AudioEngineService(ref);
});

// Provider for the sustain pedal state remains the same.
final sustainProvider = StateProvider<bool>((ref) => false);
