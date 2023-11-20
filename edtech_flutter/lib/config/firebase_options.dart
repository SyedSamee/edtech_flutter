// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD52P0hM5eb74cDiD5HP1_7euYJL-tXVNw',
    appId: '1:481296141211:web:b5d23621c68b1cc6c56f3e',
    messagingSenderId: '481296141211',
    projectId: 'edtech-flutter',
    authDomain: 'edtech-flutter.firebaseapp.com',
    storageBucket: 'edtech-flutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6Y9DhHpeXsIt7NtXvEik7WbFPfhJzkH8',
    appId: '1:481296141211:android:c63bcd2bdd54d2d2c56f3e',
    messagingSenderId: '481296141211',
    projectId: 'edtech-flutter',
    storageBucket: 'edtech-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCo1seMRQsyk-vWxD43QOI_a3v-SVT8nI',
    appId: '1:481296141211:ios:b61d1060060a64c5c56f3e',
    messagingSenderId: '481296141211',
    projectId: 'edtech-flutter',
    storageBucket: 'edtech-flutter.appspot.com',
    iosBundleId: 'com.example.edtechFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCo1seMRQsyk-vWxD43QOI_a3v-SVT8nI',
    appId: '1:481296141211:ios:e6f5535c559c2596c56f3e',
    messagingSenderId: '481296141211',
    projectId: 'edtech-flutter',
    storageBucket: 'edtech-flutter.appspot.com',
    iosBundleId: 'com.example.edtechFlutter.RunnerTests',
  );
}