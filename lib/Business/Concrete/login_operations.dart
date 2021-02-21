import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:havass_coaching_flutter/business/abstract/ilogin_operations.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:google_sign_in/google_sign_in.dart';

class IsLogin {
  bool isLoginSuccess;
  bool isEmailVerify;
  bool isFindUser;
  String message;
  IsLogin(
      {this.message,
      this.isFindUser = false,
      this.isLoginSuccess = false,
      this.isEmailVerify = false});
}

class IsForgotPassword {
  bool isSendPasswordSuccess;
  bool isError;
  String message;
  IsForgotPassword(
      {this.message, this.isSendPasswordSuccess = false, this.isError = false});
}

class IsSignUp {
  bool isSignUpSuccess;
  bool isError;
  bool isSendEmailVerification;
  String message;
  IsSignUp(
      {this.message,
      this.isSignUpSuccess = false,
      this.isError = false,
      this.isSendEmailVerification = false});
}

class LoginOperations implements ILoginOperations {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static LoginOperations _instance;

  LoginOperations._internal();

  static LoginOperations getInstance() {
    if (_instance == null) {
      _instance = LoginOperations._internal();
    }

    return _instance;
  }

  @override
  Future<IsLogin> login(HvsUser _hvsUser) async {
    IsLogin isLogin = IsLogin();
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: _hvsUser.email, password: _hvsUser.password);
      if (!user.user.emailVerified) {
        _auth.signOut();
        isLogin.isEmailVerify = true;
        return isLogin;
      } else {
        isLogin.isLoginSuccess = true;
        return isLogin;
      }
    } catch (e) {
      isLogin.message = e.toString();
      isLogin.isFindUser = true;
      return isLogin;
    }
  }

  @override
  Future<IsSignUp> signUp(HvsUser hvsuser) async {
    IsSignUp isSignUp = IsSignUp();
    try {
      var newUser = await _auth.createUserWithEmailAndPassword(
          email: hvsuser.email, password: hvsuser.password);
      if (newUser != null) {
        await newUser.user.sendEmailVerification().catchError((onError) {
          isSignUp.isSendEmailVerification = true;
          isSignUp.message = onError.toString();
        });
        await _auth.signOut();
        isSignUp.isSignUpSuccess = true;
      }
      return isSignUp;
    } catch (err) {
      isSignUp.isError = true;
      isSignUp.message = err.toString();
      return isSignUp;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      User _loginUser = _auth.currentUser;
      if (_loginUser != null) {
        await _auth.signOut();
      }
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  bool isLoggedIn() {
    var user = _auth.currentUser;
    if (user == null) {
      return false;
    }
    return user.emailVerified;
  }

  @override
  Future<IsForgotPassword> forgotPassword(String email) async {
    IsForgotPassword isForgotPassword = IsForgotPassword();
    try {
      if (email.isNotEmpty) {
        await _auth
            .sendPasswordResetEmail(email: email)
            .whenComplete(() => isForgotPassword.isSendPasswordSuccess = true)
            .catchError((onError) {
          isForgotPassword.isSendPasswordSuccess = false;
          isForgotPassword.isError = true;
          isForgotPassword.message = onError.toString();
        });
      }
      return isForgotPassword;
    } catch (err) {
      isForgotPassword.isError = true;
      isForgotPassword.message = err.toString();
      return isForgotPassword;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn()
          .signIn()
          .catchError((onError) => print("hata ile karşılaşıdı"));
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } on PlatformException catch (err) {
      print("platform hatası" + err.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
