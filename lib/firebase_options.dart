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
    apiKey: 'AIzaSyCtyvMjc6NNE4So0bqzIJi-8aZomY1kDB0',
    appId: '1:155919523006:web:8325460ac5bebccd6b52ef',
    messagingSenderId: '155919523006',
    projectId: 'sistemaweather',
    authDomain: 'sistemaweather.firebaseapp.com',
    storageBucket: 'sistemaweather.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJpNBlMXrsGjGYhDZptoEDqRjHCIjig5o',
    appId: '1:155919523006:android:817922007903b3886b52ef',
    messagingSenderId: '155919523006',
    projectId: 'sistemaweather',
    storageBucket: 'sistemaweather.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhHmZYTtmH-a9RX8TmfoOOguOfN3RwW5w',
    appId: '1:155919523006:ios:e76e8348041812926b52ef',
    messagingSenderId: '155919523006',
    projectId: 'sistemaweather',
    storageBucket: 'sistemaweather.appspot.com',
    iosClientId:
        '155919523006-9vpcifvo29onjicat5q9gc0i3j18u0kf.apps.googleusercontent.com',
    iosBundleId: 'com.example.sistemWeatherv2',
  );
}
