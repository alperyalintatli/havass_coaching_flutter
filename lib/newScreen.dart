import 'package:flutter/material.dart';
import 'business/concrete/login_operations.dart';

LoginOperations _loginOperation = LoginOperations.getInstance();

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Screen"),
      ),
      body: Container(
        child: TextButton(
          child: Text("LogOut"),
          onPressed: () => _loginOperation.signOut(context),
        ),
      ),
    );
  }
}
