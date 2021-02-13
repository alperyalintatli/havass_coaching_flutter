import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/Business/Abstract/I_login_operations.dart';
import 'package:havass_coaching_flutter/newScreen.dart';

import 'Business/Concrete/login_operations.dart';
import 'loginPage.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo2',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirebaseInitialize(),
    );
  }
}

class FirebaseInitialize extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Hata çıktı:" + snapshot.error.toString()),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          LoginOperations _loginOperation = LoginOperations.getInstance();
          return _loginOperation.isLoggedIn() ? NewScreen() : LoginPage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
