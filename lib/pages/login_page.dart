import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/pages/splash_page.dart';
import 'package:havass_coaching_flutter/plugins/bloc/bloc_localization.dart';
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
          Theme(
            data: ThemeData(
                primaryColor: Color.fromARGB(255, 0, 129, 150),
                hintColor: Colors.grey),
            child: TextFormField(
                cursorColor: Color.fromARGB(255, 0, 129, 150),
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
                    labelText: title,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true)),
          ),
        ],
      ),
    );
  }

  bool _isOnTapSubmitButton = false;
  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50.0,
      child: RaisedButton(
        disabledColor: Color.fromARGB(255, 0, 129, 150),
        color: Color.fromARGB(255, 0, 129, 150),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
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
        child: !_isOnTapSubmitButton
            ? Text(
                AppLocalizations.getString("login"),
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            : CircularProgressIndicator(),
      ),
    );
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50.0,
      child: RaisedButton(
        color: Colors.white,
        disabledColor: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.black)),
        onPressed: !_isOnTapSubmitButton
            ? () {
                _loginGmail();
                _isOnTapSubmitButton = true;
              }
            : null,
        child: !_isOnTapSubmitButton
            ? Stack(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: FaIcon(FontAwesomeIcons.google)),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.getString("sign_in_google"),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
      ),
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
                  color: Color.fromARGB(255, 0, 129, 150),
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
        text: '"${AppLocalizations.getString("nazim_hikmet_word_text")}"',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade800,
        ),
        // children: [
        //   TextSpan(
        //     text: 'va',
        //     style:
        //         TextStyle(color: Color.fromRGBO(72, 72, 72, 1), fontSize: 30),
        //   ),
        //   TextSpan(
        //     text: 'ss',
        //     style: TextStyle(
        //         color: Color.fromRGBO(164, 233, 232, 1), fontSize: 30),
        //   ),
        // ]
      ),
    );
  }

  Widget _title2() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '- Aristotle',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
          color: Colors.grey.shade800,
        ),
        // children: [
        //   TextSpan(
        //     text: 'va',
        //     style:
        //         TextStyle(color: Color.fromRGBO(72, 72, 72, 1), fontSize: 30),
        //   ),
        //   TextSpan(
        //     text: 'ss',
        //     style: TextStyle(
        //         color: Color.fromRGBO(164, 233, 232, 1), fontSize: 30),
        //   ),
        // ]
      ),
    );
  }

  Widget _title3() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: AppLocalizations.getString("nothing_is_shared_text"),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
          color: Colors.grey.shade500,
        ),
        // children: [
        //   TextSpan(
        //     text: 'va',
        //     style:
        //         TextStyle(color: Color.fromRGBO(72, 72, 72, 1), fontSize: 30),
        //   ),
        //   TextSpan(
        //     text: 'ss',
        //     style: TextStyle(
        //         color: Color.fromRGBO(164, 233, 232, 1), fontSize: 30),
        //   ),
        // ]
      ),
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
          // Positioned(
          //     top: -height * .15,
          //     right: -MediaQuery.of(context).size.width * .4,
          //     child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .12),
                  _title(),
                  _title2(),
                  SizedBox(height: 30),
                  _gmailButton(),
                  SizedBox(height: 10),
                  _title3(),
                  SizedBox(height: 30),
                  _divider(),
                  SizedBox(height: 10),
                  _emailPasswordWidget(),
                  SizedBox(height: 10),
                  _submitButton(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Image.asset('images/english-flag-icon.png'),
                          onPressed: () async {
                            FirebaseMessaging _f = FirebaseMessaging();
                            await _f.subscribeToTopic("en");
                            await _f.unsubscribeFromTopic("de");
                            setState(() {
                              BlocProvider.of<BlocLocalization>(context)
                                  .add(LocaleEvent.EN);
                            });
                          }),
                      IconButton(
                          icon: Image.asset('images/german-flag-icon.png'),
                          onPressed: () async {
                            FirebaseMessaging _f = FirebaseMessaging();
                            await _f.subscribeToTopic("de");
                            await _f.unsubscribeFromTopic("en");
                            setState(() {
                              BlocProvider.of<BlocLocalization>(context)
                                  .add(LocaleEvent.DE);
                            });
                          }),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Text(
                          AppLocalizations.getString("forgot_password") + ' ?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 129, 150),
                          )),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage())),
                    ),
                  ),
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
