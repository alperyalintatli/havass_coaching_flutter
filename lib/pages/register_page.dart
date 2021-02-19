import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/business/concrete/login_operations.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/plugins/localization/app_localizations.dart';
import 'package:havass_coaching_flutter/widget/bezier_container.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'login_page.dart';

LoginOperations _loginOperation = LoginOperations.getInstance();

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _hvsUser = HvsUser();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text(AppLocalizations.getString("back"),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title,
      {bool isPassword = false, bool isEmail = false, bool isName = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color.fromRGBO(72, 72, 72, 1)),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onSaved: (value) {
              if (isName) {
                _hvsUser.name = value;
              } else if (isPassword) {
                _hvsUser.password = value;
              } else if (isEmail) {
                _hvsUser.email = value;
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
                if (value.length < 4) {
                  return '*' +
                      AppLocalizations.getString(
                          "register_page_validation_password_field");
                }
              }
              return null;
            },
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return TextButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            setState(() {
              _formKey.currentState.save();
              _signUpUser(_hvsUser);
            });
          }
        },
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
          child: Text(
            AppLocalizations.getString("register_now"),
            style:
                TextStyle(fontSize: 20, color: Color.fromRGBO(72, 72, 72, 1)),
          ),
        ));
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
        child: Row(
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
              width: 10,
            ),
            Text(
              AppLocalizations.getString("login"),
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
            _entryField(AppLocalizations.getString("name_surname"),
                isName: true),
            _entryField(AppLocalizations.getString("email"), isEmail: true),
            _entryField(AppLocalizations.getString("password"),
                isPassword: true),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .25),
                    _title(),
                    SizedBox(
                      height: 20,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .040),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  void _signUpUser(HvsUser _hvsuser) async {
    var result = await _loginOperation.signUp(_hvsuser);
    if (result.isSendEmailVerification) {}
    if (result.isSignUpSuccess) {
      NotificationWidget.showNotification(
          context, AppLocalizations.getString("register_success_notification"));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
    if (result.isError) {
      NotificationWidget.showNotification(context,
          AppLocalizations.getString("register_error_notification_title"));
    }
  }
}
