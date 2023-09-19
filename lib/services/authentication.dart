import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> anonymousLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (error) {
      // handle error
      print("firebase auth error: $error");
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// To make this work, there are a lot of things outside of Flutter to do!
  ///
  /// First, make sure you have enabled Google sign in on Firebase by completing
  /// all the information it is asking you for, especially the support email.
  ///
  /// Then, find your SHA-1 certificate fingerprint keystore for your Android Studio
  /// emulators. This is in C:\Users\you\.android\debug.keystore.
  ///
  /// If you have Java problems, consider using the Java that comes with your
  /// Android Studio. Common issues are version problems and algorithm availability.
  ///
  /// The following command should prompt you for a password, which is 'android'
  /// by default.
  ///
  /// ```
  /// $ keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
  /// ```
  ///
  /// Your will be given two SHAs. SHA-1 and SHA-256. You need the SHA-1.
  /// It looks like this SHA1: 11:22:33:AA:BB:CC ...
  ///
  /// Take note of your SHA-1 certificate fingerprint and copy it into your
  /// Firebase project settings.
  /// Firebase > Project Settings > General > Your apps > Android apps >
  /// SHA certificate fingerprints > Add fingerprint
  Future<void> googleLogin() async {
    try {
      // interact with google to get google credentials
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // sign in onto Firebase, using the google credential
      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (error) {
      print("Google sign-in error: $error");
    }
  }
}
