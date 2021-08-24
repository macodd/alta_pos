import 'package:alta_pos/screens/login/login_screen.dart';
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

  Widget _body = Scaffold(
    backgroundColor: Colors.black12,
    body: Container(
      /// Set Background image in splash screen layout (Click to open code)
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/splash_screen.png'),
              fit: BoxFit.cover)),
      child: Container(
        /// Set gradient black in image splash screen (Click to open code)
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.1),
                  Color.fromRGBO(0, 0, 0, 0.1)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/icon/logo.png", height: 35.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 17.0, top: 7.0),
                      child: Text(
                        "Alta",
                        style: TextStyle(
                            fontFamily: "Sans",
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    if(_error) {
      return _body;
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return _body;
    }

    return LoginScreen();
  }
}
