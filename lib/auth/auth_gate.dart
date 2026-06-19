
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:myapp/auth/sign_in_screen.dart';
import 'package:myapp/main.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<fba.User?>(
      stream: fba.FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return const SignInScreen();
        }

        // Render your application if authenticated
        return const HomeScreen();
      },
    );
  }
}
