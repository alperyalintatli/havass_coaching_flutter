import 'dart:async';

import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/splash_page.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/pages/forgot_password_page.dart';
import 'package:havass_coaching_flutter/pages/register_page.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/firestore_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/back_button_widget.dart';
import 'package:havass_coaching_flutter/widget/login_register_page/bezier_container.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

LoginOperations _loginOperation = LoginOperations.getInstance();

@immutable
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  HvsUserProvider _userProvider;
  FirestoreProvider _firestoreProvider;
  final _formKey = GlobalKey<FormState>();
  final _hvsUser = HvsUser();
  bool isUserEmailVerified = false;
  bool isFindUser = false;
  @override
  void initState() {
    super.initState();
  }

  Widget _entryField(String title,
      {bool isPassword = false, bool isEmail = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              onSaved: (value) {
                if (isPassword) {
                  _hvsUser.password = value.trim();
                } else if (isEmail) {
                  _hvsUser.email = value.trim();
                }
              },
              validator: (value) {
                if (value.isEmpty) {
                  return '*' +
                      AppLocalizations.getString(
                          "register_page_validation_empty_field");
                }
                if (isEmail) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);

                  if (!emailValid) {
                    return '*' +
                        AppLocalizations.getString(
                            "register_page_validation_email_field");
                  }
                }
                if (isPassword) {
                  if (value.length < 6) {
                    return '*' +
                        AppLocalizations.getString(
                            "register_page_validation_password_field");
                  }
                }
                return null;
              },
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }

  bool _isOnTapSubmitButton = false;
  Widget _submitButton() {
    return TextButton(
        onPressed: !_isOnTapSubmitButton
            ? () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _formKey.currentState.save();
                    _loginUser(_hvsUser);
                    _isOnTapSubmitButton = true;
                  });
                }
              }
            : null,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(0, 121, 250, 0),
                    Color.fromRGBO(164, 233, 232, 1),
                  ])),
          child: !_isOnTapSubmitButton
              ? Text(
                  AppLocalizations.getString("login"),
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(72, 72, 72, 1)),
                )
              : CircularProgressIndicator(),
        ));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text(AppLocalizations.getString("or")),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _gmailButton() {
    return TextButton(
      child: Row(
        children: [
          IconButton(
              color: Colors.red,
              icon: Image.asset(
                'images/logo-gmail.png',
                height: 150,
                width: 150,
              ),
              onPressed: !_isOnTapSubmitButton
                  ? () {
                      setState(() {
                        _loginGmail();
                        _isOnTapSubmitButton = true;
                      });
                    }
                  : null),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      onPressed: null,
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.getString("dont_have_an _account") + ' ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizations.getString("register_now"),
              style: TextStyle(
                  color: Color.fromRGBO(164, 233, 232, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Ha',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(164, 233, 232, 1),
          ),
          children: [
            TextSpan(
              text: 'va',
              style:
                  TextStyle(color: Color.fromRGBO(72, 72, 72, 1), fontSize: 30),
            ),
            TextSpan(
              text: 'ss',
              style: TextStyle(
                  color: Color.fromRGBO(164, 233, 232, 1), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _entryField(AppLocalizations.getString("email"), isEmail: true),
            _entryField(AppLocalizations.getString("password"),
                isPassword: true),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<HvsUserProvider>(context);
    _firestoreProvider = Provider.of<FirestoreProvider>(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .20),
                  _title(),
                  SizedBox(height: 30),
                  _emailPasswordWidget(),
                  SizedBox(height: 10),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(
                          AppLocalizations.getString("forgot_password") + ' ?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(164, 233, 232, 1),
                          )),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage())),
                    ),
                  ),
                  _divider(),
                  _gmailButton(),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(
              top: 40, left: 0, child: BackButtonWidget(context: context)),
        ],
      ),
    ));
  }

  void _loginGmail() async {
    var result = await _loginOperation.signInWithGoogle();
    if (result != null) {
      Timer(Duration(seconds: 3), () {
        NotificationWidget.showNotification(
            context,
            AppLocalizations.getString(
                "login_gmail_notification_success_title"));
        _userProvider.getUser();
        setState(() {
          _isOnTapSubmitButton = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
      });
    } else {
      setState(() {
        _isOnTapSubmitButton = false;
      });

      NotificationWidget.showNotification(context,
          AppLocalizations.getString("login_gmail_notification_error_title"));
    }
  }

  void _loginUser(HvsUser _hvsuser) async {
    var isLogin = await _loginOperation.login(_hvsuser);
    if (isLogin.isLoginSuccess) {
      _userProvider.getUser(hvsUser: _hvsUser);
      _firestoreProvider.getHomeSlider();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PageSplash()),
          (Route<dynamic> route) => false);
    } else if (isLogin.isEmailVerify) {
      setState(() {
        _isOnTapSubmitButton = false;
        NotificationWidget.showNotification(
            context,
            AppLocalizations.getString(
                "login_mailVerified_notification_title"));
      });
    } else if (isLogin.isFindUser) {
      setState(() {
        _isOnTapSubmitButton = false;
        NotificationWidget.showNotification(context,
            AppLocalizations.getString("login_findUser_notification_title"));
      });
    }
  }
}
