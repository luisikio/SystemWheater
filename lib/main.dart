import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/routes/app_routes.dart';
import 'package:sistem_weatherv2/routes/routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SystemWheather',
      initialRoute: Routes.home,
      routes: appRoutes,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          color: Color(0xff1F2432),
        ),
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          // ignore: deprecated_member_use
          bodyText2: TextStyle(
            color: Colors.white,
          ),

          // ignore: deprecated_member_use
          subtitle2: TextStyle(
            color: Colors.white,
          ),
          // headline1: TextStyle(
          //   color: Colors.white,
          // ),
          // headline2: TextStyle(
          //   color: Colors.white,
          // ),
          // caption: TextStyle(
          //   color: Colors.white,
          // ),
          // button: TextStyle(
          //   color: Colors.white,
          // ),
          // overline: TextStyle(
          //   color: Colors.white,
          // ),
        ),
      ),
    );
  }
}
