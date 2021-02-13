import 'package:flutter/material.dart';

abstract class ILoginOperations {
  void login(BuildContext context);
  void signUp(BuildContext context);
  void signOut();
  Widget controlOfSignIn(BuildContext context);
}
