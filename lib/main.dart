import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'login/login.dart';
import 'login/login_choices.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FirebaseDemonstration());
}

class FirebaseDemonstration extends StatefulWidget {
  const FirebaseDemonstration({super.key});

  @override
  State<FirebaseDemonstration> createState() => _FirebaseDemonstrationState();
}

class _FirebaseDemonstrationState extends State<FirebaseDemonstration> {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> initialization = Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return MaterialApp(
      home: FutureBuilder(
        future: initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(body: Center(child: Text("Error")));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Scaffold(body: Center(child: Text("Loading")));
        },
      ),
    );
  }
}
