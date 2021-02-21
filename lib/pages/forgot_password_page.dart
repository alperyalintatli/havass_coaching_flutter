import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/widget/back_button_widget.dart';
import 'package:havass_coaching_flutter/widget/login_register_page/bezier_container.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'login_page.dart';

LoginOperations _loginOperation = LoginOperations.getInstance();

@immutable
class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _hvsUser = HvsUser();
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
                  if (value.length < 4) {
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

  Widget _submitButton() {
    return Container(
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
        child: TextButton(
          child: Text(
            AppLocalizations.getString("forgot_password_sendEmail_button"),
            style:
                TextStyle(fontSize: 20, color: Color.fromRGBO(72, 72, 72, 1)),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              setState(() {
                _formKey.currentState.save();
                _forgotPassword(_hvsUser);
              });
            }
          },
        ));
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

  Widget _emailWidget() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _entryField(AppLocalizations.getString("email"), isEmail: true)
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
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
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
    ));
  }

  void _forgotPassword(HvsUser _hvsuser) async {
    if (_hvsUser.email.isNotEmpty) {
      var result = await _loginOperation.forgotPassword(_hvsUser.email);
      if (result.isError) {
        NotificationWidget.showNotification(context,
            AppLocalizations.getString("forgot_pasword_notification_error"));
      }
      if (result.isSendPasswordSuccess) {
        NotificationWidget.showNotification(context,
            AppLocalizations.getString("forgot_pasword_notification_succcess"));
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      }
    }
  }
}
