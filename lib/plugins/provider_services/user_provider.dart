import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/plugins/firebase_database_services/firebase_database_operations.dart';

class HvsUserProvider with ChangeNotifier {
  DatabaseOperation _databaseOperation = DatabaseOperation.getInstance();
  HvsUser _hvsUser;
  HvsUser get getHvsUser => this._hvsUser;

  set setHvsUser(HvsUser hvsUser) => this._hvsUser = _hvsUser;

  void getUser({HvsUser hvsUser}) async {
    this._hvsUser = await _databaseOperation.getUser(hvsUser: hvsUser);
    notifyListeners();
  }

  Future<bool> changeUserName(String userName) async {
    bool result = await _databaseOperation.changeUserName(userName);
    getUser();
    return result;
  }
}
