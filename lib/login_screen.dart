import 'package:flutter/material.dart';
import 'Business/Concrete/login_operations.dart';

LoginOperations _loginOperation = LoginOperations.getInstance();

class LoginOperation extends StatefulWidget {
  @override
  _LoginOperationState createState() => _LoginOperationState();
}

class _LoginOperationState extends State<LoginOperation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login İslemleri"),
      ),
      body: Center(
          child: Column(
        children: [
          RaisedButton(
            child: Text("Kullanıcı Oluştur/Email-Password"),
            color: Colors.blue,
            onPressed: _createUser,
          ),
          RaisedButton(
            child: Text("Login"),
            color: Colors.blue,
            onPressed: _login,
          ),
          RaisedButton(
            child: Text("Cıkıs yap"),
            color: Colors.blue,
            onPressed: _signOutUser,
          ),
        ],
      )),
    );
  }

  // void _controlSignIn() async {
  //   _loginOperation.controlOfSignIn(context);
  // }

  void _signOutUser() async {
    _loginOperation.signOut();
  }

  void _createUser() async {
    _loginOperation.signUp(context);
  }

  void _login() {
    _loginOperation.login(context);
  }
}
