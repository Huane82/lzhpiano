
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

@immutable
class AudioEngineState {
  final bool isLoading;
  final bool isLoaded;
  final String? error;

  const AudioEngineState({
    this.isLoading = false,
    this.isLoaded = false,
    this.error,
  });

  AudioEngineState copyWith({
    bool? isLoading,
    bool? isLoaded,
    String? error,
  }) {
    return AudioEngineState(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
    );
  }
}

class AudioEngineService extends StateNotifier<AudioEngineState> {
  final Ref _ref;
  final List<AudioPlayer> _playerPool = [];
  final Map<int, AudioPlayer> _playingNotes = {};
  final AudioCache _audioCache = AudioCache(prefix: 'assets/audio/');
  final int _poolSize = 16;

  // Constructor is now clean and synchronous.
  AudioEngineService(this._ref) : super(const AudioEngineState()) {
    // Initialize the player pool synchronously.
    for (int i = 0; i < _poolSize; i++) {
      _playerPool.add(AudioPlayer());
    }
  }

  // This method is now explicitly called from the UI layer.
  Future<void> loadSamples() async {
    if (state.isLoaded || state.isLoading) return; // Prevent multiple loads

    state = state.copyWith(isLoading: true, error: null);
    debugPrint('Starting to cache audio samples...');

    try {
      final filesToCache = List.generate(88, (i) => '${i + 1}.mp3');
      await _audioCache.loadAll(filesToCache);
      state = state.copyWith(isLoading: false, isLoaded: true);
      debugPrint('All 88 audio samples cached successfully!');
    } catch (e) {
      debugPrint('Error caching audio samples: $e');
      state = state.copyWith(isLoading: false, error: 'Failed to load piano samples. Please restart the app.');
    }
  }

  AudioPlayer? _getAvailablePlayer() {
    try {
      return _playerPool.firstWhere((p) => p.state != PlayerState.playing);
    } catch (e) {
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

final audioEngineProvider = StateNotifierProvider<AudioEngineService, AudioEngineState>((ref) {
  return AudioEngineService(ref);
});

final sustainProvider = StateProvider<bool>((ref) => false);
