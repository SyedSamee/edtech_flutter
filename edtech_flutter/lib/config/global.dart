import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edtech_flutter/views/auth/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' as _get;

void listenFirebaseUser(BuildContext context) async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  firebaseAuth.userChanges().listen((User? user) {
    if (user == null) {
      _get.Get.offAll(() => LoginScreen(),
          transition: _get.Transition.rightToLeft,
          duration: Duration(milliseconds: 500));
    }
  });
}
