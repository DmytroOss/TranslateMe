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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAryikGMMQCxtv9KIH2ue3q9-g3iuEcl4w',
    appId: '1:390147127814:web:bd9c36c09158c23654e187',
    messagingSenderId: '390147127814',
    projectId: 'translateme-4ce6d',
    authDomain: 'translateme-4ce6d.firebaseapp.com',
    storageBucket: 'translateme-4ce6d.appspot.com',
    measurementId: 'G-M8JPJNRCYB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCN44AQeUyAzamf_bD_oVmElCbeBLC6q9M',
    appId: '1:390147127814:android:8371e249e5acd72f54e187',
    messagingSenderId: '390147127814',
    projectId: 'translateme-4ce6d',
    storageBucket: 'translateme-4ce6d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMS5PaknHDCObUtzXDRRfdtJICxBzQLjc',
    appId: '1:390147127814:ios:184ce72bdbfcccaa54e187',
    messagingSenderId: '390147127814',
    projectId: 'translateme-4ce6d',
    storageBucket: 'translateme-4ce6d.appspot.com',
    iosBundleId: 'com.example.translationApp',
  );
}
