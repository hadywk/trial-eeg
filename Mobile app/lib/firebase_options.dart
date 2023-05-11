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
    apiKey: 'AIzaSyDqq62x4Iy-SFDFDTBHPH89StnusCcliL8',
    appId: '1:963049959103:web:852568c5f0be02bf8ae00a',
    messagingSenderId: '963049959103',
    projectId: 'graduation-7ef9c',
    authDomain: 'graduation-7ef9c.firebaseapp.com',
    storageBucket: 'graduation-7ef9c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZtCc860livf-wOEl0VmXHoqVCXe4OgBU',
    appId: '1:963049959103:android:e5e194271fe033d38ae00a',
    messagingSenderId: '963049959103',
    projectId: 'graduation-7ef9c',
    storageBucket: 'graduation-7ef9c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDfpqdxS2N-BiWn7LexTeNu_y37r-Xins',
    appId: '1:963049959103:ios:2fc9d0a5179d8d408ae00a',
    messagingSenderId: '963049959103',
    projectId: 'graduation-7ef9c',
    storageBucket: 'graduation-7ef9c.appspot.com',
    iosClientId: '963049959103-qlrio2qavon0r59akdn3n9smi22iob4l.apps.googleusercontent.com',
    iosBundleId: 'com.example.graduation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDfpqdxS2N-BiWn7LexTeNu_y37r-Xins',
    appId: '1:963049959103:ios:2fc9d0a5179d8d408ae00a',
    messagingSenderId: '963049959103',
    projectId: 'graduation-7ef9c',
    storageBucket: 'graduation-7ef9c.appspot.com',
    iosClientId: '963049959103-qlrio2qavon0r59akdn3n9smi22iob4l.apps.googleusercontent.com',
    iosBundleId: 'com.example.graduation',
  );
}
