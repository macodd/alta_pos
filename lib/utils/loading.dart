import 'package:alta_pos/screens/login/login_screen.dart';
import 'package:alta_pos/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

/// Component UI
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    if(_error) {
      return LoadingScreen();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return LoadingScreen();
    }

    return LoginScreen();
  }
}
