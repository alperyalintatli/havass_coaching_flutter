import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/ILogin_operations.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:havass_coaching_flutter/plugins/firebase_database_services/firebase_database_operations.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';

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

class IsChangePassword {
  bool isChangePasswordSuccess;
  bool isError;
  String message;
  bool isValidatePassword;
  IsChangePassword(
      {this.message,
      this.isChangePasswordSuccess = false,
      this.isError = false,
      this.isValidatePassword = false});
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
  LoginOperations();
  LoginOperations._internal();
  static LoginOperations getInstance() =>
      _instance == null ? _instance = LoginOperations._internal() : _instance;

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
  Future<IsSignUp> signUp(HvsUser hvsUser) async {
    IsSignUp isSignUp = IsSignUp();
    try {
      var newUser = await _auth.createUserWithEmailAndPassword(
          email: hvsUser.email, password: hvsUser.password);
      if (newUser != null) {
        await _auth.setLanguageCode(await PrefUtils.getLanguage());
        await newUser.user.sendEmailVerification().catchError((onError) {
          isSignUp.isSendEmailVerification = true;
          isSignUp.message = onError.toString();
        }).then((value) async {
          isSignUp.isSignUpSuccess = true;
          DatabaseOperation _databaseOperation =
              DatabaseOperation.getInstance();
          hvsUser.role = "Student";
          hvsUser.course = [];
          await _databaseOperation
              .saveUserCreate(hvsUser)
              .then((value) async => await _auth.signOut());
        });
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
        await _auth.setLanguageCode(await PrefUtils.getLanguage());
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

  @override
  Future<IsChangePassword> changePassword(
      String oldPassword, String newPassword) async {
    IsChangePassword isChangePassword = IsChangePassword();
    try {
      var result = await _validatePassword(oldPassword);
      if (result) {
        if (newPassword.isNotEmpty) {
          await _auth.currentUser.updatePassword(newPassword).then((value) {
            isChangePassword.isChangePasswordSuccess = true;
          });
          // }
          return isChangePassword;
        }
      } else {
        isChangePassword.isValidatePassword = true;
      }
      return isChangePassword;
    } catch (err) {
      isChangePassword.isValidatePassword = true;
      isChangePassword.isError = true;
      isChangePassword.message = err.toString();
      return isChangePassword;
    }
  }

  Future<bool> _validatePassword(String password) async {
    var credential = EmailAuthProvider.credential(
        email: _auth.currentUser.email, password: password);
    var userCredential =
        await _auth.currentUser.reauthenticateWithCredential(credential);
    if (userCredential != null) {
      return true;
    }
    return false;
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
      HvsUser _hvsUser = HvsUser();
      _hvsUser.email = googleUser.email;
      DatabaseOperation _databaseOperation = DatabaseOperation.getInstance();
      var user = await _databaseOperation.getUser(hvsUser: _hvsUser);
      if (user != null) {
        HvsUser hvsUser = HvsUser();
        hvsUser.role = "Student";
        hvsUser.course = user.course;

        hvsUser.email = googleUser.email;
        hvsUser.name = googleUser.email.split('@')[0];
        _databaseOperation.saveUserCreate(hvsUser);
      } else {
        HvsUser hvsUser = HvsUser();
        hvsUser.role = "Student";

        hvsUser.course = [];

        hvsUser.email = googleUser.email;
        hvsUser.name = googleUser.email.split('@')[0];
        _databaseOperation.saveUserCreate(hvsUser);
      }
      return await _auth.signInWithCredential(credential);
    } on PlatformException catch (err) {
      print("platform hatası" + err.toString());
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String getLoginUserEmail() {
    return _auth.currentUser.email;
  }
}
