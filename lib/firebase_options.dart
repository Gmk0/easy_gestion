// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCQEgJcxZL10KBW78H4PGeriODiGDcdJFY',
    appId: '1:820106528496:web:ec70599ff446e8d1302435',
    messagingSenderId: '820106528496',
    projectId: 'gestion-easy',
    authDomain: 'gestion-easy.firebaseapp.com',
    storageBucket: 'gestion-easy.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWddGC-KJrDC2bEi8aVEYs-KA3U8qj6p0',
    appId: '1:681795301103:android:9634f2282f1a36a125b51a',
    messagingSenderId: '681795301103',
    projectId: 'gestion-easy-4e879',
    storageBucket: 'gestion-easy-4e879.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNlYJdyAHRvKW8iTQnZl0rB8Xy-DuMC-w',
    appId: '1:681795301103:ios:5f8b01b20753626d25b51a',
    messagingSenderId: '681795301103',
    projectId: 'gestion-easy-4e879',
    storageBucket: 'gestion-easy-4e879.firebasestorage.app',
    iosBundleId: 'com.example.easyGestion',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCQEgJcxZL10KBW78H4PGeriODiGDcdJFY',
    appId: '1:820106528496:web:c317a11d6e8ba42b302435',
    messagingSenderId: '820106528496',
    projectId: 'gestion-easy',
    authDomain: 'gestion-easy.firebaseapp.com',
    storageBucket: 'gestion-easy.firebasestorage.app',
  );
}