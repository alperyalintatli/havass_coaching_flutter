import 'package:havass_coaching_flutter/model/users.dart';

abstract class ILoginOperations {
  void login(HvsUser _hvsUser);
  void signUp(HvsUser hvsuser);
  void signOut();
  bool isLoggedIn();
  void forgotPassword(String email);
}
