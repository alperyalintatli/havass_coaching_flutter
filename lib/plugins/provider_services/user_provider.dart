import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/plugins/firebase_database_services/firebase_database_operations.dart';

class HvsUserProvider with ChangeNotifier {
  DatabaseOperation _databaseOperation = DatabaseOperation.getInstance();
  HvsUser _hvsUser;
  HvsUser get getHvsUser {
    return this._hvsUser;
  }

  set setHvsUser(HvsUser hvsUser) => this._hvsUser = _hvsUser;

  Future<void> getUser({HvsUser hvsUser}) async {
    this._hvsUser = await _databaseOperation.getUser(hvsUser: hvsUser);
    _checkRole();
    notifyListeners();
  }

  Future<void> createCourse(HvsUser hvsUser) async {
    await _databaseOperation.saveCourseCreate(hvsUser);
    notifyListeners();
  }

  Future<bool> changeUserName(String userName) async {
    bool result = await _databaseOperation.changeUserName(userName);
    getUser();
    return result;
  }

  bool _isAdmin = false;
  bool get getIsAdmin => this._isAdmin;
  set setIsAdmin(bool isAdmin) => this._isAdmin = isAdmin;
  void _checkRole() async {
    var _isAdmin = await _databaseOperation.isAdmin();
    var _isUserAdmin = Constants.constants().contains(_hvsUser.role);
    if (_isAdmin == _isUserAdmin) {
      this._isAdmin = true;
    }
  }
}
