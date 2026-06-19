
import 'package:freezed_annotation/freezed_annotation.dart';

part 'playback_state.freezed.dart';

// Enums
enum PlaybackStatus { stopped, playing, paused }
enum PracticeMode { normal, wait }
enum HandIsolation { both, leftOnly, rightOnly }

@freezed
abstract class PlaybackState with _$PlaybackState {

  // This private constructor is required by freezed.
  const PlaybackState._();

  // This factory constructor is the main entry point for creating a PlaybackState.
  // Freezed will generate the implementation for `_PlaybackState`.
  const factory PlaybackState({
    @Default(PlaybackStatus.stopped) PlaybackStatus status,
    @Default(1.0) double speed,
    @Default(Duration.zero) Duration progress,
    @Default(PracticeMode.normal) PracticeMode practiceMode,
    @Default(HandIsolation.both) HandIsolation handIsolation,
    @Default(false) bool isLooping,
    Duration? loopStart,
    Duration? loopEnd,
    @Default(<int>{}) Set<int> waitingForNotes,
  }) = _PlaybackState;
}
