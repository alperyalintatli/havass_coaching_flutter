import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/business/concrete/login_operations.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/pages/register_page.dart';
import 'package:havass_coaching_flutter/plugins/localization/app_localizations.dart';
import 'package:havass_coaching_flutter/widget/bezier_container.dart';
import 'package:overlay_support/overlay_support.dart';

LoginOperations _loginOperation = LoginOperations.getInstance();

class LoginPage extends StatefulWidget {
  LoginPage(
      {Key key,
      this.title,
      this.isRouteOfRegisterPage = false,
      this.isUserEmailVerified = false})
      : super(key: key);
  bool isRouteOfRegisterPage = false;
  bool isUserEmailVerified = false;
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _hvsUser = HvsUser();
  @override
  void initState() {
    super.initState();
  }

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
            AppLocalizations.getString("login"),
            style:
                TextStyle(fontSize: 20, color: Color.fromRGBO(72, 72, 72, 1)),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              setState(() {
                _formKey.currentState.save();
                _loginUser(_hvsUser);
              });
            }
          },
        ));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
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
        margin: EdgeInsets.symmetric(vertical: 20),
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
    final height = MediaQuery.of(context).size.height;

    if (widget.isRouteOfRegisterPage) {
      Future.delayed(
          Duration.zero, () => _showAlertRegisterNotification(context));
    }
    if (widget.isUserEmailVerified) {
      Future.delayed(Duration.zero, () => _showAlertUserEmailVerified(context));
    }

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
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                        AppLocalizations.getString("forgot_password") + ' ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  _divider(),
                  // _facebookButton(),
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }

  void _loginUser(HvsUser _hvsuser) async {
    _loginOperation.login(context, _hvsuser);
  }

  void _showAlertRegisterNotification(BuildContext context) {
    showOverlayNotification((context) {
      widget.isRouteOfRegisterPage = false;
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: SafeArea(
          child: ListTile(
            leading: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(
                child: Container(
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green.shade200,
                    size: 40.0,
                  ),
                ),
              ),
            ),
            title: Text(
                AppLocalizations.getString("register_success_notification")),
            subtitle: Text(
                AppLocalizations.getString("register_to_login_notification")),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                OverlaySupportEntry.of(context).dismiss();
              },
            ),
          ),
        ),
      );
    }, duration: Duration(milliseconds: 6000));
  }

  void _showAlertUserEmailVerified(BuildContext context) {
    showOverlayNotification((context) {
      widget.isUserEmailVerified = false;
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: SafeArea(
          child: ListTile(
            leading: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(
                child: Container(
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green.shade200,
                    size: 40.0,
                  ),
                ),
              ),
            ),
            title: Text(AppLocalizations.getString(
                "login_mailVerified_notification_title")),
            subtitle: Text(AppLocalizations.getString(
                "login_mailVerified_notification_subtitle")),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                OverlaySupportEntry.of(context).dismiss();
              },
            ),
          ),
        ),
      );
    }, duration: Duration(milliseconds: 6000));
  }
}
