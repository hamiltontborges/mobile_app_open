// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyChIF5U05Vk3s7RTRnfAjKJ0feufRp8C5A',
    appId: '1:237002829077:web:444dd2722089bdb444cd1c',
    messagingSenderId: '237002829077',
    projectId: 'open-unifeob-b3ec3',
    authDomain: 'open-unifeob-b3ec3.firebaseapp.com',
    storageBucket: 'open-unifeob-b3ec3.appspot.com',
    measurementId: 'G-61ZP6DGK2T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDf1PdC5vrHDu5U6zlhwvVIqYIstXfwgy4',
    appId: '1:237002829077:android:a36c3ef9fffa747844cd1c',
    messagingSenderId: '237002829077',
    projectId: 'open-unifeob-b3ec3',
    storageBucket: 'open-unifeob-b3ec3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpihJ5TNnjPrc0nPRbXdcZk5gLTQ1afOM',
    appId: '1:237002829077:ios:d23682d26eac7bb244cd1c',
    messagingSenderId: '237002829077',
    projectId: 'open-unifeob-b3ec3',
    storageBucket: 'open-unifeob-b3ec3.appspot.com',
    iosClientId: '237002829077-5agfardbujs38ub13truirfp9m1r7jl7.apps.googleusercontent.com',
    iosBundleId: 'com.example.open-unifeob',
  );
}
