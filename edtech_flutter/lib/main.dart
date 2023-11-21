import 'package:edtech_flutter/config/firebase_options.dart';
import 'package:edtech_flutter/config/utils.dart';
import 'package:edtech_flutter/views/auth/login/login_screen.dart';
import 'package:edtech_flutter/views/auth/register/register_screen.dart';
import 'package:edtech_flutter/views/course_player/courseplayer_screen.dart';
import 'package:edtech_flutter/views/dashboard/dashboard_screen.dart';
import 'package:edtech_flutter/views/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edtech Flutter',
      theme: Utils().themeData,
      home: const DashboardScreen(),
    );
  }
}
