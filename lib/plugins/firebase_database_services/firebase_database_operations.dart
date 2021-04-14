import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/plugins/firebase_database_services/IDatabase_operations.dart';

class DatabaseOperation extends IDatabaseOperation {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static DatabaseOperation _instance;

  DatabaseOperation._internal();

  static DatabaseOperation getInstance() =>
      _instance == null ? _instance = DatabaseOperation._internal() : _instance;

  void saveUserCreate(HvsUser hvsUser) async {
    try {
      await _firestore
          .collection("users")
          .doc(hvsUser.email)
          .set(hvsUser.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> saveCourseCreate(HvsUser hvsUser) async {
    try {
      await _firestore
          .collection("users")
          .doc(hvsUser.email)
          .set(hvsUser.toMap(), SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> changeUserName(String userName) async {
    LoginOperations _loginOperation = LoginOperations.getInstance();
    Map<String, dynamic> map = Map<String, dynamic>();
    map["userName"] = userName;
    try {
      await _firestore
          .collection("users")
          .doc(_loginOperation.getLoginUserEmail())
          .set(map, SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<HvsUser> getUser({HvsUser hvsUser}) async {
    HvsUser _hvs;
    try {
      if (hvsUser != null) {
        await _firestore
            .collection("users")
            .doc(hvsUser.email)
            .get()
            .then((value) {
          _hvs = HvsUser.fromMap(value.data());
        });
      } else {
        LoginOperations _loginOperation = LoginOperations.getInstance();
        await _firestore
            .collection("users")
            .doc(_loginOperation.getLoginUserEmail())
            .get()
            .then((value) {
          _hvs = HvsUser.fromMap(value.data());
        });
      }

      return _hvs;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isAdmin() async {
    try {
      LoginOperations _loginOperation = LoginOperations.getInstance();
      if (_loginOperation.isLoggedIn()) {
        var _loginUser = _loginOperation.getLoginUserEmail();
        var result = await _firestore.collection("roles").doc("admin").get();
        Map<String, dynamic> map = Map<String, dynamic>();
        map = result.data();
        map.containsValue(_loginUser);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getSliderListWithDb() async {
    Map<String, dynamic> map = Map<String, dynamic>();
    try {
      var result =
          await _firestore.collection("slider_images").doc("home_slider").get();

      map = result.data();
      return map;
    } catch (e) {
      print(e);
      return map;
    }
  }

  Future<Map<String, dynamic>> getQuatOfImage() async {
    Map<String, dynamic> map = Map<String, dynamic>();
    try {
      var result =
          await _firestore.collection("quat_of_images").doc("images").get();
      map = result.data();
      return map;
    } catch (e) {
      print(e);
      return map;
    }
  }
}
