
// Defines the data structure for a single musical note within a song.
class MusicalNote {
  // The MIDI note number (e.g., 60 for C4).
  final int noteNumber;
  // Which hand is meant to play this note.
  final NoteHand hand;
  // When the note should start playing.
  final Duration startTime;
  // How long the note should be held.
  final Duration duration;

  const MusicalNote({
    required this.noteNumber,
    required this.hand,
    required this.startTime,
    required this.duration,
  });

  // Calculates when the note should end.
  Duration get endTime => startTime + duration;
}

enum NoteHand {
  left,
  right,
}

// A placeholder song for development and testing purposes.
final List<MusicalNote> placeholderSong = [
  // A simple C Major scale for the right hand
  MusicalNote(hand: NoteHand.right, noteNumber: 60, startTime: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 400)), // C4
  MusicalNote(hand: NoteHand.right, noteNumber: 62, startTime: const Duration(milliseconds: 1000), duration: const Duration(milliseconds: 400)),// D4
  MusicalNote(hand: NoteHand.right, noteNumber: 64, startTime: const Duration(milliseconds: 1500), duration: const Duration(milliseconds: 400)),// E4
  MusicalNote(hand: NoteHand.right, noteNumber: 65, startTime: const Duration(milliseconds: 2000), duration: const Duration(milliseconds: 400)),// F4
  MusicalNote(hand: NoteHand.right, noteNumber: 67, startTime: const Duration(milliseconds: 2500), duration: const Duration(milliseconds: 400)),// G4
  MusicalNote(hand: NoteHand.right, noteNumber: 69, startTime: const Duration(milliseconds: 3000), duration: const Duration(milliseconds: 400)),// A4
  MusicalNote(hand: NoteHand.right, noteNumber: 71, startTime: const Duration(milliseconds: 3500), duration: const Duration(milliseconds: 400)),// B4
  MusicalNote(hand: NoteHand.right, noteNumber: 72, startTime: const Duration(milliseconds: 4000), duration: const Duration(milliseconds: 800)),// C5

  // A simple bass line for the left hand
  MusicalNote(hand: NoteHand.left, noteNumber: 48, startTime: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 800)), // C3
  MusicalNote(hand: NoteHand.left, noteNumber: 52, startTime: const Duration(milliseconds: 2000), duration: const Duration(milliseconds: 800)),// E3
  MusicalNote(hand: NoteHand.left, noteNumber: 53, startTime: const Duration(milliseconds: 3500), duration: const Duration(milliseconds: 800)),// F3
];

// Calculate the total duration of the placeholder song.
final Duration placeholderSongDuration = placeholderSong.fold(
  Duration.zero,
  (max, note) => note.endTime > max ? note.endTime : max,
);
