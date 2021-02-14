import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/users.dart';

abstract class ILoginOperations {
  void login(BuildContext context);
  void signUp(BuildContext context, HvsUser user);
  void signOut();
  Widget controlOfSignIn(BuildContext context);
}
