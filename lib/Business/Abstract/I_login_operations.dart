import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/users.dart';

abstract class ILoginOperations {
  void login(BuildContext context, HvsUser user);
  void signUp(BuildContext context, HvsUser user);
  void signOut(BuildContext context);
  // Widget controlOfSignIn(BuildContext context);
}
