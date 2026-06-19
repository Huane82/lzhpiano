
import 'package:flutter/material.dart';

// A utility class to hold information about each key.
class PianoNote {
  final int noteNumber; // MIDI note number (1-88, A0 = 21, C8 = 108)
  final String name; // e.g., C4, F#5
  final bool isBlackKey;

  const PianoNote(this.noteNumber, this.name, this.isBlackKey);

  // A static list to easily access all notes, mapping to standard MIDI numbers.
  static final List<PianoNote> allNotes = List.generate(88, (i) {
    final noteNumber = i + 21; // Start from A0 (MIDI note 21)
    final noteIndex = i % 12;
    final octave = (noteNumber - 12) ~/ 12;
    const noteNames = ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#'];
    final isBlack = [false, true, false, false, true, false, true, false, false, true, false, true][noteIndex];
    return PianoNote(noteNumber, '${noteNames[noteIndex]}$octave', isBlack);
  });
}


// The widget that draws a single, beautifully styled piano key.
class PianoKey extends StatelessWidget {
  final PianoNote note;
  final double keyWidth;
  final double keyHeight;
  final bool isPressed;

  const PianoKey({
    super.key,
    required this.note,
    required this.keyWidth,
    required this.keyHeight,
    this.isPressed = false,
  });

  @override
  Widget build(BuildContext context) {
    final blackKeyHeight = keyHeight * 0.6;
    final blackKeyWidth = keyWidth * 0.65;

    final whiteKeyGradient = LinearGradient(
      colors: isPressed 
          ? [Colors.grey[300]!, Colors.grey[400]!]
          : [Colors.white, Colors.grey[200]!],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final blackKeyGradient = LinearGradient(
      colors: isPressed
          ? [Colors.grey[700]!, Colors.grey[800]!]
          : [const Color(0xFF222222), const Color(0xFF444444)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final keyDecoration = BoxDecoration(
      gradient: note.isBlackKey ? blackKeyGradient : whiteKeyGradient,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6.0)),
      border: note.isBlackKey
        ? Border.all(color: Colors.black, width: 1.5)
        : Border.all(color: Colors.grey[400]!, width: 1),
      boxShadow: [
        // A more subtle, multi-layered shadow for a "lifted" look.
        if (!isPressed) 
          BoxShadow(
            color: Colors.black.withOpacity(note.isBlackKey ? 0.6 : 0.25),
            blurRadius: note.isBlackKey ? 4.0 : 3.0,
            spreadRadius: 1.0,
            offset: const Offset(0.0, 3.0),
          ),
      ],
    );

    return Container(
      width: note.isBlackKey ? blackKeyWidth : keyWidth,
      height: note.isBlackKey ? blackKeyHeight : keyHeight,
      decoration: keyDecoration,
      child: note.isBlackKey ? null : _buildWhiteKeyLabel(),
    );
  }

  Widget _buildWhiteKeyLabel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          note.name,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: keyWidth * 0.25, // Responsive font size
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
