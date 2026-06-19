# LZHPiano Blueprint

## Overview

This document outlines the architecture, features, and development plan for the LZHPiano Flutter application.

## Phase 1: Core Infrastructure & Authentication (Complete)

*   **Project Directory Structure:** Organized project for Riverpod state management (`auth`, `home`, etc.).
*   **Firebase & Google Sign-In:** Configured Firebase for Android/iOS, implemented Google Sign-In, and managed authentication state using Riverpod.
*   **Authentication Repository:** Created `AuthRepository` to handle Google Sign-In, Sign-Out, and auth state changes.
*   **UI Flow:** Implemented a basic UI flow with a `LoginScreen` and `HomeScreen`, controlled by an `AuthChecker`.
*   **Dependency Management:** Managed core dependencies (`firebase_core`, `firebase_auth`, `google_sign_in`, `flutter_riverpod`).

---

## Phase 2: Low-Latency Audio Engine (Complete)

### Specifications:

1.  **Asset Mapping & Loading:**
    *   **Action:** The engine maps and pre-loads 88 local MP3 files (e.g., `1.mp3` to `88.mp3`) from the `assets/audio/` directory.
    *   **Implementation:** Used a `Future.wait` loop within the `AudioEngineService` to load all samples in parallel at app startup, storing them in a `Map<int, int>` that links note numbers to sound IDs.

2.  **Polyphony & Low Latency:**
    *   **Action:** Implemented a high-performance audio pool engine for polyphonic playback without lag.
    *   **Implementation:** Utilized the `soundpool` package, configured with `StreamType.music` and `maxStreams: 88`. This allows all 88 keys to sound simultaneously, which is critical for sustain pedal functionality.

3.  **Audio Safety & Performance:**
    *   **Action:** Ensured sound blends naturally without distortion or clipping, and optimized memory usage.
    *   **Implementation:** `soundpool` handles the low-level mixing of audio streams. By pre-loading samples via `rootBundle.load` and having `soundpool` manage them, memory is handled efficiently by the native audio engines (Oboe/AVAudioEngine).

4.  **Sustain Pedal State Management:**
    *   **Action:** Created a global state for the sustain pedal.
    *   **Implementation:** 
        *   A `Sustain` class (`StateNotifier<bool>`) was created to hold the pedal's state (on/off).
        *   The `stopNote` method in `AudioEngineService` now checks this state. If sustain is on, the note is not stopped programmatically, allowing it to decay naturally.

### Architecture & Initialization:

*   **`AudioEngineService`:** A dedicated service class (`lib/audio/audio_engine_service.dart`) encapsulates all audio-related logic.
*   **Riverpod Integration:**
    *   `audioEngineProvider`: A `Provider` that creates and holds the singleton instance of `AudioEngineService`.
    *   `sustainProvider`: A `StateNotifierProvider` that makes the sustain pedal state accessible and modifiable throughout the app.
*   **Initialization in `main.dart`:**
    *   A `FutureProvider` (`audioEngineInitializerProvider`) was created to handle the asynchronous loading of audio samples.
    *   The `MyApp` widget now listens to this provider, displaying a `SplashScreen` with a "Tuning Pianos..." message while samples are loading, ensuring the app is fully ready before the UI is interactive.
