import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future registerUser(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      //register to firebase with email and password
      var registerResponse = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (registerResponse.user != null) {
        sharedPreferences.setString("userId", registerResponse.user!.uid);
        return true;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }
}
