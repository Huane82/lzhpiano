
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/data/song_data.dart';
import 'firebase_options.dart';

import 'package:myapp/playback/playback_controller.dart';
import 'package:myapp/playback/playback_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piano Mate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthGate(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackState = ref.watch(playbackControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Piano Mate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Piano Mate!',
            ),
            // Add the debug playback controls here
            if (ref.read(playbackControllerProvider.notifier).isDebug) 
              DebugPlaybackControls(
                playbackState: playbackState, 
                songDuration: placeholderSongDuration
              ),
          ],
        ),
      ),
    );
  }
}


class DebugPlaybackControls extends ConsumerWidget {
  final PlaybackState playbackState;
  final Duration songDuration;

  const DebugPlaybackControls({super.key, required this.playbackState, required this.songDuration});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackController = ref.read(playbackControllerProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Debug Controls', style: Theme.of(context).textTheme.headlineSmall),
          // Play/Pause/Stop Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: playbackController.play,
              ),
              IconButton(
                icon: const Icon(Icons.pause),
                onPressed: playbackController.pause,
              ),
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: playbackController.stop,
              ),
            ],
          ),
          // Speed Control Slider
          Row(
            children: [
              const Text('Speed'),
              Expanded(
                child: Slider(
                  value: playbackState.speed,
                  min: 0.5,
                  max: 2.0,
                  onChanged: playbackController.setSpeed,
                ),
              ),
              Text(playbackState.speed.toStringAsFixed(2)),
            ],
          ),
          // Progress Slider
          Slider(
            value: playbackState.progress.inMilliseconds.toDouble(),
            min: 0.0,
            max: songDuration.inMilliseconds.toDouble(),
            onChanged: (value) => playbackController.setProgress(Duration(milliseconds: value.toInt())),
          ),
          // Practice Mode Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Practice Mode:'),
              Switch(
                value: playbackState.practiceMode == PracticeMode.wait,
                onChanged: (isWaiting) {
                  playbackController.setPracticeMode(isWaiting ? PracticeMode.wait : PracticeMode.normal);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
