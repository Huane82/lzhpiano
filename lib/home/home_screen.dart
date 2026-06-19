
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/debug/debug_playback_controls.dart';
import 'package:myapp/piano_ui/falling_notes_painter.dart';
import 'package:myapp/piano_ui/piano_keyboard.dart';
import 'package:myapp/piano_ui/piano_key.dart';
import 'package:myapp/playback/playback_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyCount = ref.watch(keyboardLayoutProvider);
    final playbackState = ref.watch(playbackControllerProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // This is the new Debug UI
            const DebugPlaybackControls(),
            Expanded(
              flex: 4,
              child: LayoutBuilder(builder: (context, constraints) {
                final whiteKeys = PianoNote.allNotes.sublist(0, keyCount).where((n) => !n.isBlackKey).length;
                final whiteKeyWidth = constraints.maxWidth / whiteKeys;
                return CustomPaint(
                  size: Size.infinite,
                  // Pass the playback state to the painter
                  painter: FallingNotesPainter(
                    playbackState: playbackState,
                    keyCount: keyCount,
                    whiteKeyWidth: whiteKeyWidth,
                  ),
                );
              }),
            ),
            const Expanded(
              flex: 3,
              child: PianoKeyboard(),
            ),
          ],
        ),
      ),
    );
  }
}
