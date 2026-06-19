
import 'package:flutter/material.dart';
import 'package:myapp/data/song_data.dart';
import 'package:myapp/piano_ui/piano_key.dart';
import 'package:myapp/playback/playback_state.dart';

class FallingNotesPainter extends CustomPainter {
  final PlaybackState playbackState;
  final int keyCount;
  final double whiteKeyWidth;

  // The total duration of the timeline visible on screen at any time.
  static const Duration _visibleDuration = Duration(seconds: 4);

  FallingNotesPainter({
    required this.playbackState,
    required this.keyCount,
    required this.whiteKeyWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final allKeys = PianoNote.allNotes.sublist(0, keyCount);
    final double blackKeyWidth = whiteKeyWidth * 0.6;

    final currentProgressMs = playbackState.progress.inMilliseconds;
    final visibleDurationMs = _visibleDuration.inMilliseconds;

    for (final note in placeholderSong) {
      // Calculate the vertical position of the note.
      final noteStartMs = note.startTime.inMilliseconds;
      final noteEndMs = note.endTime.inMilliseconds;

      // Only paint notes that are currently visible.
      if (noteEndMs < currentProgressMs || noteStartMs > currentProgressMs + visibleDurationMs) {
        continue;
      }

      final yStart = size.height - ((noteStartMs - currentProgressMs) / visibleDurationMs) * size.height;
      final yEnd = size.height - ((noteEndMs - currentProgressMs) / visibleDurationMs) * size.height;
      final height = yStart - yEnd;

      // Find the corresponding key to get its position and color.
      final keyIndex = allKeys.indexWhere((k) => k.noteNumber == note.noteNumber);
      if (keyIndex == -1) continue;

      final key = allKeys[keyIndex];
      final keyPosition = _getKeyPosition(key, keyCount, whiteKeyWidth);

      final paint = Paint()..color = _getNoteColor(note.hand, key.isBlackKey);
      final rect = Rect.fromLTWH(
        keyPosition,
        yEnd, // Flutter canvas Y is from top to bottom
        key.isBlackKey ? blackKeyWidth : whiteKeyWidth,
        height,
      );
      canvas.drawRect(rect, paint);
    }
  }

  Color _getNoteColor(NoteHand hand, bool isBlackKey) {
    if (hand == NoteHand.left) {
      return isBlackKey ? Colors.purple.shade900 : Colors.purple.shade400;
    } else { // Right Hand
      return isBlackKey ? Colors.blue.shade900 : Colors.blue.shade400;
    }
  }

  double _getKeyPosition(PianoNote key, int keyCount, double whiteKeyWidth) {
    final whiteKeysBefore = PianoNote.allNotes.sublist(0, key.noteNumber - 21).where((n) => !n.isBlackKey).length;
    if (key.isBlackKey) {
      return (whiteKeysBefore * whiteKeyWidth) - (whiteKeyWidth * 0.3);
    } else {
      return whiteKeysBefore * whiteKeyWidth;
    }
  }

  @override
  bool shouldRepaint(covariant FallingNotesPainter oldDelegate) {
    // Repaint whenever the playback state changes.
    return oldDelegate.playbackState != playbackState;
  }
}
