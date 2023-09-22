import 'package:flutter/material.dart';

import '../services/authentication.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}
