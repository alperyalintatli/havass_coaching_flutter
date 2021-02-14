import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/Business/Abstract/I_login_operations.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/pages/login_page.dart';
import 'package:havass_coaching_flutter/pages/welcome_page.dart';
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
  void login(BuildContext context, HvsUser _hvsUser) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: _hvsUser.email, password: _hvsUser.password);
      if (!user.user.emailVerified) {
        signOut(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginPage(
                  isUserEmailVerified: true,
                )));
        print("Emailinizi onaylayınız.");
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
  void signUp(BuildContext context, HvsUser hvsuser) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: hvsuser.email, password: hvsuser.password)
          .then((result) => {
                result.user.sendEmailVerification().catchError((onError) {
                  print(onError.toString());
                  print("Hata oluştu");
                })
              })
          .whenComplete(() {
        signOut(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginPage(
                  isRouteOfRegisterPage: true,
                )));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void signOut(BuildContext context) async {
    User _loginUser = _auth.currentUser;
    if (_loginUser != null) {
      await _auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomePage()),
          (Route<dynamic> route) => false);
    }
  }

  bool isLoggedIn() {
    var user = _auth.currentUser;
    if (user == null) {
      return false;
    }
    return user.emailVerified;
  }
}
