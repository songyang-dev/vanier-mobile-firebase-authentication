import 'package:flutter/material.dart';

import '../services/authentication.dart';
import 'login_choices.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Text("Waiting"),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Error")),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Welcome"),
            ),
            body: Center(
              child: ElevatedButton(
                child: const Text("Sign out"),
                onPressed: () => AuthService().signOut(),
              ),
            ),
          );
        } else {
          return const LoginSelectionScreen();
        }
      },
    );
  }
}
