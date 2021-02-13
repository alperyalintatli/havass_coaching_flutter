import 'package:flutter/material.dart';

abstract class ILoginOperations {
  void login(BuildContext context);
  void signIn();
  void signOut();
  Widget controlOfSignIn(BuildContext context);
}
