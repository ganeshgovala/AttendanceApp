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
        return macos;
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
    apiKey: 'AIzaSyC83lFlgZwsKyqlhbm9Bu7xSzohZ2qytX0',
    appId: '1:629628007764:web:b81db75f42e0866db704c1',
    messagingSenderId: '629628007764',
    projectId: 'attendance-app-a8d84',
    authDomain: 'attendance-app-a8d84.firebaseapp.com',
    storageBucket: 'attendance-app-a8d84.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBw4sEmoi9ZXoDfrWf1T3Dbtu0t0m90X8c',
    appId: '1:629628007764:android:0c23e184485855bbb704c1',
    messagingSenderId: '629628007764',
    projectId: 'attendance-app-a8d84',
    storageBucket: 'attendance-app-a8d84.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0hcxKge0WgVKIAVN4olMF2D_Fes0Kn74',
    appId: '1:629628007764:ios:d78ef0c133cbba12b704c1',
    messagingSenderId: '629628007764',
    projectId: 'attendance-app-a8d84',
    storageBucket: 'attendance-app-a8d84.appspot.com',
    iosBundleId: 'com.example.attendance',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0hcxKge0WgVKIAVN4olMF2D_Fes0Kn74',
    appId: '1:629628007764:ios:d78ef0c133cbba12b704c1',
    messagingSenderId: '629628007764',
    projectId: 'attendance-app-a8d84',
    storageBucket: 'attendance-app-a8d84.appspot.com',
    iosBundleId: 'com.example.attendance',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC83lFlgZwsKyqlhbm9Bu7xSzohZ2qytX0',
    appId: '1:629628007764:web:d3dc528659661791b704c1',
    messagingSenderId: '629628007764',
    projectId: 'attendance-app-a8d84',
    authDomain: 'attendance-app-a8d84.firebaseapp.com',
    storageBucket: 'attendance-app-a8d84.appspot.com',
  );
}
