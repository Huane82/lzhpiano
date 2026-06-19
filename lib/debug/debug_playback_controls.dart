
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/playback/playback_controller.dart';
import 'package:myapp/playback/playback_state.dart';

class DebugPlaybackControls extends ConsumerWidget {
  const DebugPlaybackControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackState = ref.watch(playbackControllerProvider);
    final controller = ref.read(playbackControllerProvider.notifier);

    // Assume total song duration is 10 seconds for the slider.
    const totalDuration = Duration(seconds: 10);

    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black.withOpacity(0.7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Playback and Progress ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: const Icon(Icons.play_arrow), onPressed: controller.play, color: Colors.white),
              IconButton(icon: const Icon(Icons.pause), onPressed: controller.pause, color: Colors.white),
              IconButton(icon: const Icon(Icons.stop), onPressed: controller.stop, color: Colors.white),
            ],
          ),
          Slider(
            value: playbackState.progress.inMilliseconds.toDouble(),
            min: 0,
            max: totalDuration.inMilliseconds.toDouble(),
            onChanged: (value) {
              controller.seek(Duration(milliseconds: value.toInt()));
            },
          ),

          // --- Speed Control ---
          Row(
            children: [
              const Text('Speed:', style: TextStyle(color: Colors.white)),
              Expanded(
                child: Slider(
                  value: playbackState.speed,
                  min: 0.1,
                  max: 10.0,
                  divisions: 99,
                  label: playbackState.speed.toStringAsFixed(1),
                  onChanged: (value) {
                    controller.setSpeed(value);
                  },
                ),
              ),
              Text('${playbackState.speed.toStringAsFixed(1)}x', style: TextStyle(color: Colors.white)),
            ],
          ),

          // --- Mode Toggles ---
          Wrap(
            spacing: 8.0,
            children: [
              FilterChip(label: const Text('Wait Mode'), selected: playbackState.practiceMode == PracticeMode.wait, onSelected: (selected) => controller.setPracticeMode(selected ? PracticeMode.wait : PracticeMode.normal)),
              FilterChip(label: const Text('Left Hand'), selected: playbackState.handIsolation == HandIsolation.leftOnly, onSelected: (selected) => controller.setHandIsolation(selected ? HandIsolation.leftOnly : HandIsolation.both)),
              FilterChip(label: const Text('Right Hand'), selected: playbackState.handIsolation == HandIsolation.rightOnly, onSelected: (selected) => controller.setHandIsolation(selected ? HandIsolation.rightOnly : HandIsolation.both)),
            ],
          ),
          
          // --- State Display ---
          Card(
            color: Colors.grey.shade900,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Status: ${playbackState.status.name} | Progress: ${playbackState.progress.inSeconds}s | Mode: ${playbackState.practiceMode.name} | Isolation: ${playbackState.handIsolation.name}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
