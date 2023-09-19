import 'package:flutter/material.dart';

import '../services/authentication.dart';

class LoginSelectionScreen extends StatelessWidget {
  const LoginSelectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Select a login method"),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await AuthService().anonymousLogin();
              },
              icon: const Icon(Icons.mobile_off_sharp),
              label: const Text("Anonymous"),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await AuthService().googleLogin();
              },
              icon: const Icon(Icons.g_mobiledata),
              label: const Text("Google"),
            ),
          ],
        ),
      ),
    );
  }
}
