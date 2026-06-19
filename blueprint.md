# LZHPiano Blueprint

## Overview

This document outlines the architecture, features, and development plan for the LZHPiano Flutter application.

## Current Plan

### Phase 1: Core Infrastructure, Firebase, and Google Sign-In

1.  **Project Directory Structure:**
    *   Create a directory structure optimized for Riverpod state management.
    *   Organize the project into `auth`, `data`, and `presentation` layers.

2.  **Firebase and Google Sign-In Configuration:**
    *   Add `firebase_core`, `firebase_auth`, `google_sign_in`, `flutter_riverpod`, and `permission_handler` to `pubspec.yaml`.
    *   Configure Firebase for Android and provide instructions for iOS.

3.  **Authentication Repository:**
    *   Implement an `AuthRepository` class to handle Google Sign-In, Sign-Out, and listen to authentication state changes.
    *   Use Riverpod to provide the authentication state to the application.

4.  **Native Permission Workflows:**
    *   Outline the necessary configurations in `AndroidManifest.xml` and `Info.plist` for Microphone, Bluetooth, and Storage permissions.
