
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/audio/audio_engine_service.dart';
import 'package:myapp/piano_ui/piano_key.dart';

// A provider to manage the state of the keyboard layout (61 or 88 keys).
final keyboardLayoutProvider = StateProvider<int>((ref) => 88);

class PianoKeyboard extends ConsumerStatefulWidget {
  const PianoKeyboard({super.key});

  @override
  ConsumerState<PianoKeyboard> createState() => _PianoKeyboardState();
}

class _PianoKeyboardState extends ConsumerState<PianoKeyboard> {
  // Maps a pointer/finger ID to the note number it's currently pressing.
  final Map<int, int> _activePointers = {};
  // A set of all notes currently pressed down.
  final Set<int> _pressedNotes = {};

  // Cache layout information to avoid recalculating on every touch event.
  double _whiteKeyWidth = 0.0;
  double _keyboardHeight = 0.0;
  List<Rect> _blackKeyHitboxes = [];
  List<Rect> _whiteKeyHitboxes = [];
  int _keyCount = 0;

  @override
  Widget build(BuildContext context) {
    // Use a Listener for raw pointer events to handle true multi-touch.
    return Listener(
      onPointerDown: _handlePointerDown,
      onPointerMove: _handlePointerMove,
      onPointerUp: _handlePointerUp,
      onPointerCancel: _handlePointerUp, // Treat cancel same as up
      child: LayoutBuilder(
        builder: (context, constraints) {
          _updateLayout(constraints);
          return Stack(
            children: [
              _buildWhiteKeys(constraints),
              _buildBlackKeys(constraints),
            ],
          );
        },
      ),
    );
  }

  void _updateLayout(BoxConstraints constraints) {
    final keyCount = ref.watch(keyboardLayoutProvider);
    final whiteKeys = PianoNote.allNotes.sublist(0, keyCount).where((n) => !n.isBlackKey).length;
    
    _keyCount = keyCount;
    _whiteKeyWidth = constraints.maxWidth / whiteKeys;
    _keyboardHeight = constraints.maxHeight;
    final blackKeyWidth = _whiteKeyWidth * 0.65;
    final blackKeyHeight = _keyboardHeight * 0.6;

    _whiteKeyHitboxes.clear();
    _blackKeyHitboxes.clear();

    double currentX = 0;
    final allKeys = PianoNote.allNotes.sublist(0, keyCount);
    for(var i=0; i< allKeys.length; i++){
        final note = allKeys[i];
        if(!note.isBlackKey){
            _whiteKeyHitboxes.add(Rect.fromLTWH(currentX, 0, _whiteKeyWidth, _keyboardHeight));
            currentX += _whiteKeyWidth;
        }
    }

    currentX = 0;
    for(var i=0; i< allKeys.length; i++){
        final note = allKeys[i];
        if(!note.isBlackKey){
            currentX += _whiteKeyWidth;
        }
        else{
            final blackKeyRect = Rect.fromLTWH(currentX - blackKeyWidth/2, 0, blackKeyWidth, blackKeyHeight);
            _blackKeyHitboxes.add(blackKeyRect);
        }
    }
  }

  // --- Pointer Handling Logic ---

  void _handlePointerDown(PointerDownEvent event) {
    _updateNoteForPointer(event.pointer, event.localPosition);
  }

  void _handlePointerMove(PointerMoveEvent event) {
    _updateNoteForPointer(event.pointer, event.localPosition);
  }

  void _handlePointerUp(PointerEvent event) {
    _releaseNoteForPointer(event.pointer);
  }

  void _updateNoteForPointer(int pointerId, Offset localPosition) {
    final audioEngine = ref.read(audioEngineProvider.notifier);
    final noteToPlay = _hitTest(localPosition);

    final currentlyPressedNote = _activePointers[pointerId];

    if (noteToPlay != null && currentlyPressedNote != noteToPlay) {
      // A new note is pressed by this finger
      audioEngine.playNote(noteToPlay);
      if (mounted) {
        setState(() {
          _pressedNotes.add(noteToPlay);
          _activePointers[pointerId] = noteToPlay;
        });
      }
      // Stop the previous note if the finger slid to a new key
      if (currentlyPressedNote != null) {
        audioEngine.stopNote(currentlyPressedNote);
        if (mounted) {
          setState(() {
            _pressedNotes.remove(currentlyPressedNote);
          });
        }
      }
    }
  }

  void _releaseNoteForPointer(int pointerId) {
    final noteToStop = _activePointers[pointerId];
    if (noteToStop != null) {
      ref.read(audioEngineProvider.notifier).stopNote(noteToStop);
      if (mounted) {
        setState(() {
          _pressedNotes.remove(noteToStop);
          _activePointers.remove(pointerId);
        });
      }
    }
  }

  int? _hitTest(Offset position) {
    final allKeys = PianoNote.allNotes.sublist(0, _keyCount);

    // Prioritize black keys as they are on top.
    for (int i = _blackKeyHitboxes.length - 1; i >= 0; i--) {
        if(_blackKeyHitboxes[i].contains(position)){
            int blackKeyIndex = 0;
            for(int j=0; j < allKeys.length; j++){
                if(allKeys[j].isBlackKey){
                    if(blackKeyIndex == i){
                        return allKeys[j].noteNumber;
                    }
                    blackKeyIndex++;
                }
            }
        }
    }

    // Then check white keys.
    for (int i = 0; i < _whiteKeyHitboxes.length; i++) {
        if(_whiteKeyHitboxes[i].contains(position)){
            int whiteKeyIndex = 0;
            for(int j=0; j < allKeys.length; j++){
                if(!allKeys[j].isBlackKey){
                    if(whiteKeyIndex == i){
                        return allKeys[j].noteNumber;
                    }
                    whiteKeyIndex++;
                }
            }
        }
    }

    return null;
  }


  // --- UI Building ---

  Widget _buildWhiteKeys(BoxConstraints constraints) {
    final whiteKeys = PianoNote.allNotes.sublist(0, _keyCount).where((n) => !n.isBlackKey);
    return Row(
      children: whiteKeys.map((note) {
        return PianoKey(
          note: note,
          keyWidth: _whiteKeyWidth,
          keyHeight: _keyboardHeight,
          isPressed: _pressedNotes.contains(note.noteNumber),
        );
      }).toList(),
    );
  }

  Widget _buildBlackKeys(BoxConstraints constraints) {
    final allKeys = PianoNote.allNotes.sublist(0, _keyCount);
    final blackKeyWidth = _whiteKeyWidth * 0.65;

    double currentX = 0;
    List<Widget> blackKeyWidgets = [];

    for (var note in allKeys) {
      if (!note.isBlackKey) {
        currentX += _whiteKeyWidth;
      } else {
        blackKeyWidgets.add(
          Positioned(
            left: currentX - (blackKeyWidth / 2),
            top: 0,
            child: PianoKey(
              note: note,
              keyWidth: _whiteKeyWidth, // Pass parent width for context
              keyHeight: _keyboardHeight, // Pass parent height for context
              isPressed: _pressedNotes.contains(note.noteNumber),
            ),
          ),
        );
      }
    }
    return Stack(children: blackKeyWidgets);
  }
}
