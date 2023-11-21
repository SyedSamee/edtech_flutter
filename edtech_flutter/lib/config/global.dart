import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edtech_flutter/views/auth/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void listenFirebaseUser(BuildContext context) async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  firebaseAuth.userChanges().listen((User? user) {
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }
  });
}
