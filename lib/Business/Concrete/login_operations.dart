import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/Business/Abstract/I_login_operations.dart';
import 'package:havass_coaching_flutter/login_screen.dart';
import '../../loginPage.dart';
import '../../newScreen.dart';

class LoginOperations implements ILoginOperations {
  FirebaseAuth _auth = FirebaseAuth.instance;

  static LoginOperations _instance;

  LoginOperations._internal();

  static LoginOperations getInstance() {
    if (_instance == null) {
      _instance = LoginOperations._internal();
    }

    return _instance;
  }

  @override
  void login(BuildContext context) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: "alicanerderin@gmail.com", password: "password");
      if (!user.user.emailVerified) {
        print("Emailinizi onaylayınız.");
        signOut();
      } else {
        print("giriş yapıldı.");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewScreen()));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void signUp(BuildContext context) async {
    String email = "alicanerderin@gmail.com";
    String password = "password";
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) => {
                result.user.sendEmailVerification().catchError((onError) {
                  print(onError.toString());
                  print("Hata oluştu");
                })
              })
          .whenComplete(() {
        signOut();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void signOut() async {
    User _loginUser = _auth.currentUser;
    if (_loginUser != null) {
      await _auth.signOut();
    }
  }

  bool isLoggedIn() {
    var user = _auth.currentUser;
    if (user == null) {
      return false;
    }
    return user.emailVerified;
  }

  @override
  Widget controlOfSignIn(BuildContext context) {
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        if (user.emailVerified) {
          print('User is signed in!');
          return NewScreen();
        } else {
          print('Email doğrulayınız!');
          return LoginOperation();
        }
      }
    });
    return LoginOperation();
  }
}
