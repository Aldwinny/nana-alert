import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign in
  Future<UserCredential> signInWithGoogle() async {
    // Begin Sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtain Auth Details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    print("Signed in");

    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        print("User signed out.");
      } else {
        print("User signed in.");
      }
    });

    // Sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    print("signed out");
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        print("User signed out.");
      } else {
        print("User signed in.");
      }
    });
    return await FirebaseAuth.instance.signOut();
  }
}
