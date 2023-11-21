import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future loginUser(String email, String password) async {
    firebaseAuth.currentUser != null ? {firebaseAuth.signOut()} : null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      //Login to firebase with email and password
      var loginResponse = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (loginResponse.user != null) {
        sharedPreferences.setString("userId", loginResponse.user!.uid);
        return true;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }
}
