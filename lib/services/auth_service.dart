import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> userExists(String email, String password) async {
    try {
      List<String> authentications =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (authentications.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
  }

  User getCurrentUser() {
    return auth.currentUser;
  }
}
