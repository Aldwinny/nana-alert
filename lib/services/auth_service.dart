import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign in
  signInWithGoogle() async {
    // Begin Sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtain Auth Details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    // Sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
