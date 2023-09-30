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
    apiKey: 'AIzaSyCPLPKXIUwdWrl-u395sR98_p_z3L1lKbs',
    appId: '1:831371680379:web:9ed2723cd7a56ac42f60de',
    messagingSenderId: '831371680379',
    projectId: 'onepointdelivery-6f132',
    authDomain: 'onepointdelivery-6f132.firebaseapp.com',
    storageBucket: 'onepointdelivery-6f132.appspot.com',
    measurementId: 'G-VGYWT106GJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWq5daCgKZ0sdrQ-Cr38LzFB7AyjfIvDc',
    appId: '1:831371680379:android:88d98b479a6885282f60de',
    messagingSenderId: '831371680379',
    projectId: 'onepointdelivery-6f132',
    storageBucket: 'onepointdelivery-6f132.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVKoJvi7owy484z8MFxOxFBShrqhy50Gk',
    appId: '1:831371680379:ios:f405c30c63d02f3c2f60de',
    messagingSenderId: '831371680379',
    projectId: 'onepointdelivery-6f132',
    storageBucket: 'onepointdelivery-6f132.appspot.com',
    iosClientId: '831371680379-u8v8n107r5u3bls6hbatupdhk70en9up.apps.googleusercontent.com',
    iosBundleId: 'com.example.onPointDelivery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDVKoJvi7owy484z8MFxOxFBShrqhy50Gk',
    appId: '1:831371680379:ios:80f4c583f0dfeb0d2f60de',
    messagingSenderId: '831371680379',
    projectId: 'onepointdelivery-6f132',
    storageBucket: 'onepointdelivery-6f132.appspot.com',
    iosClientId: '831371680379-h5o77umj7pio2t2ql1cegs7h8qmpmara.apps.googleusercontent.com',
    iosBundleId: 'com.example.onPointDelivery.RunnerTests',
  );
}
