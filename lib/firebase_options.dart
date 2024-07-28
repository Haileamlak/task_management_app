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
    apiKey: 'AIzaSyDOV1rn0-3hWmjkdsm_2MWjDV25SpKa6gQ',
    appId: '1:927830802611:web:ac0d32b65d81f0149bb0c6',
    messagingSenderId: '927830802611',
    projectId: 'task-management-app-674e5',
    authDomain: 'task-management-app-674e5.firebaseapp.com',
    storageBucket: 'task-management-app-674e5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANp-h7P4lmcLxGuJQ11nLdpRq3V5Bl_hk',
    appId: '1:927830802611:android:06a658748748582a9bb0c6',
    messagingSenderId: '927830802611',
    projectId: 'task-management-app-674e5',
    storageBucket: 'task-management-app-674e5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvwV1v2N3RjsRcskqX1x4Zg2ZegVQg5vk',
    appId: '1:927830802611:ios:08a064a22c0ec45c9bb0c6',
    messagingSenderId: '927830802611',
    projectId: 'task-management-app-674e5',
    storageBucket: 'task-management-app-674e5.appspot.com',
    iosBundleId: 'com.example.taskManagementApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvwV1v2N3RjsRcskqX1x4Zg2ZegVQg5vk',
    appId: '1:927830802611:ios:8cd3c6660148a3869bb0c6',
    messagingSenderId: '927830802611',
    projectId: 'task-management-app-674e5',
    storageBucket: 'task-management-app-674e5.appspot.com',
    iosBundleId: 'com.example.taskManagementApp.RunnerTests',
  );
}