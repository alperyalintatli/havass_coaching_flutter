import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/pages/home_page.dart';
import 'package:havass_coaching_flutter/plugins/bloc/bloc_localization.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/back_button_widget.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';

LoginOperations _loginOperation = LoginOperations.getInstance();

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  HvsUserProvider _userProvider;
  final _formKey = GlobalKey<FormState>();
  final _hvsUser = HvsUser();
  Widget _entryField(String title,
      {bool isPassword = false, bool isEmail = false, bool isName = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Theme(
            data: ThemeData(
                primaryColor: Color.fromARGB(255, 0, 129, 150),
                hintColor: Colors.grey),
            child: TextFormField(
              cursorColor: Color.fromARGB(255, 0, 129, 150),
              obscureText: isPassword,
              decoration: InputDecoration(
                  labelText: title,
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true),
              onSaved: (value) {
                if (isName) {
                  _hvsUser.name = value.trim();
                } else if (isPassword) {
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

                if (isEmail == true) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);

                  if (!emailValid) {
                    return '*' +
                        AppLocalizations.getString(
                            "register_page_validation_email_field");
                  }
                }
                if (isPassword == true) {
                  if (value.length < 6) {
                    return '*' +
                        AppLocalizations.getString(
                            "register_page_validation_password_field");
                  }
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  bool _isOnTapButton = false;
  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50.0,
      child: RaisedButton(
        color: Color.fromARGB(255, 0, 129, 150),
        disabledColor: Color.fromARGB(255, 0, 129, 150),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        onPressed: !_isOnTapButton
            ? () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _formKey.currentState.save();
                    _signUpUser(_hvsUser);
                    _isOnTapButton = true;
                  });
                }
              }
            : null,
        child: !_isOnTapButton
            ? Text(
                AppLocalizations.getString("register_now"),
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
      ),
    );
  }

  Widget _googleButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50.0,
      child: RaisedButton(
        color: Colors.white,
        disabledColor: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.black)),
        onPressed: !_isOnTapButton
            ? () {
                setState(() {
                  _loginGmail();
                  _isOnTapButton = true;
                });
              }
            : null,
        child: !_isOnTapButton
            ? Stack(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: FaIcon(FontAwesomeIcons.google)),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.getString("sign_up_google"),
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

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.getString("already_have_an_account") + '?',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(72, 72, 72, 1)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.getString("login"),
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
        text: '"${AppLocalizations.getString("save_preferences_text")}"',
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

  // Widget _title2() {
  //   return RichText(
  //     textAlign: TextAlign.center,
  //     text: TextSpan(
  //       text: '- Aristotle',
  //       style: TextStyle(
  //         fontSize: 15,
  //         fontWeight: FontWeight.w300,
  //         color: Colors.grey.shade800,
  //       ),
  //       // children: [
  //       //   TextSpan(
  //       //     text: 'va',
  //       //     style:
  //       //         TextStyle(color: Color.fromRGBO(72, 72, 72, 1), fontSize: 30),
  //       //   ),
  //       //   TextSpan(
  //       //     text: 'ss',
  //       //     style: TextStyle(
  //       //         color: Color.fromRGBO(164, 233, 232, 1), fontSize: 30),
  //       //   ),
  //       // ]
  //     ),
  //   );
  // }

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
            _entryField(AppLocalizations.getString("name_surname"),
                isName: true),
            _entryField(AppLocalizations.getString("email"), isEmail: true),
            _entryField(AppLocalizations.getString("password"),
                isPassword: true)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<HvsUserProvider>(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            // Positioned(
            //   top: -MediaQuery.of(context).size.height * .15,
            //   right: -MediaQuery.of(context).size.width * .4,
            //   child: BezierContainer(),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .12),
                    _title(),
                    SizedBox(
                      height: 30,
                    ),
                    _googleButton(),
                    SizedBox(
                      height: 25,
                    ),
                    _title3(),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalizations.getString("or"),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _emailPasswordWidget(),
                    _submitButton(),
                    SizedBox(
                      height: 5,
                    ),
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
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 40,
                left: 0,
                child: BackButtonWidget(
                  context: context,
                )),
          ],
        ),
      ),
    );
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
          _isOnTapButton = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
      });
    } else {
      setState(() {
        _isOnTapButton = false;
      });

      NotificationWidget.showNotification(context,
          AppLocalizations.getString("login_gmail_notification_error_title"));
    }
  }

  void _signUpUser(HvsUser _hvsuser) async {
    var result = await _loginOperation.signUp(_hvsuser);
    if (result.isSendEmailVerification) {}
    if (result.isSignUpSuccess) {
      setState(() {
        _isOnTapButton = false;
      });
      NotificationWidget.showNotification(
          context, AppLocalizations.getString("register_success_notification"));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
    if (result.isError) {
      setState(() {
        _isOnTapButton = false;
      });
      NotificationWidget.showNotification(context,
          AppLocalizations.getString("register_error_notification_title"));
    }
  }
}
