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
    apiKey: 'AIzaSyA4IuGvcYspbLnDs31ZyYX72dQmfZBUEjg',
    appId: '1:1048414381370:web:6325fbd3c097f9fceb5c03',
    messagingSenderId: '1048414381370',
    projectId: 'flutter-train-2024',
    authDomain: 'flutter-train-2024.firebaseapp.com',
    storageBucket: 'flutter-train-2024.appspot.com',
    measurementId: 'G-XCD08VQX4X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZT_7TQ0NAJTOkn_a_F1VJLo-wJwYMp5o',
    appId: '1:1048414381370:android:745ca46bad03900feb5c03',
    messagingSenderId: '1048414381370',
    projectId: 'flutter-train-2024',
    storageBucket: 'flutter-train-2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB64N38nL9uxE651isIy_CkD53cwEbPTfI',
    appId: '1:1048414381370:ios:457c469919d4bc6beb5c03',
    messagingSenderId: '1048414381370',
    projectId: 'flutter-train-2024',
    storageBucket: 'flutter-train-2024.appspot.com',
    iosBundleId: 'com.example.namaaPoject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB64N38nL9uxE651isIy_CkD53cwEbPTfI',
    appId: '1:1048414381370:ios:40899448942bdc3ceb5c03',
    messagingSenderId: '1048414381370',
    projectId: 'flutter-train-2024',
    storageBucket: 'flutter-train-2024.appspot.com',
    iosBundleId: 'com.example.namaaPoject.RunnerTests',
  );
}
