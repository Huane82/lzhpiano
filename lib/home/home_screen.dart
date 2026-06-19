
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/audio/audio_engine_service.dart';
import 'package:myapp/auth/auth_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;
    // Watch the audio engine service to get its loaded status.
    final isAudioLoaded = ref.watch(audioEngineProvider).isLoaded;

    // Show a loading indicator at the bottom if audio is not ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isAudioLoaded) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text('Piano samples are loading...'),
              ],
            ),
            duration: Duration(days: 1), // Keep it visible until loaded
          ),
        );
      } else {
        // Once loaded, remove the SnackBar.
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('LZHPiano'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authRepositoryProvider).signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user?.displayName ?? 'User'}!'),
            const SizedBox(height: 20),
            // A simple placeholder for where the piano keys will go.
            const Text('Piano will be here.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      // We ensure the ScaffoldMessenger is available for our SnackBar.
      // This is a simple way to achieve this without needing a separate Builder widget.
      floatingActionButton: const SizedBox.shrink(), 
    );
  }
}
