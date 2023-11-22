import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future registerUser(String name, String email, String password) async {
    firebaseAuth.currentUser != null ? {firebaseAuth.signOut()} : null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      //register to firebase with email and password
      var registerResponse = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (registerResponse.user != null) {
        sharedPreferences.setString("userId", registerResponse.user!.uid);
        await firebaseFirestore
            .collection("users")
            .doc(registerResponse.user!.uid)
            .set({"name": name, "email": email});
        return true;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }
}
