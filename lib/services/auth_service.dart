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

  Future<UserCredential> createAccountWithEmail(
      String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
