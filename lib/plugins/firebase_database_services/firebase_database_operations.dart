import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/model/courses.dart';
import 'package:havass_coaching_flutter/model/logs.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/plugins/firebase_database_services/IDatabase_operations.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:uuid/uuid.dart';

class DatabaseOperation extends IDatabaseOperation {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static DatabaseOperation _instance;

  DatabaseOperation._internal();

  static DatabaseOperation getInstance() =>
      _instance == null ? _instance = DatabaseOperation._internal() : _instance;

  Future<void> saveUserCreate(HvsUser hvsUser) async {
    try {
      await _firestore
          .collection("users")
          .doc(hvsUser.email)
          .set(hvsUser.toMap());
      Logs logs = Logs();
      logs.log = [];
      await _firestore.collection("logs").doc(hvsUser.email).set(logs.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  void saveLog(Log log, String userEmail) async {
    try {
      await _firestore
          .collection("logs")
          .doc(userEmail)
          .get()
          .then((value) async {
        var logs = Logs.fromMap(value.data());
        var uuid = Uuid();
        log.logId = uuid.v1();
        logs.log.add(log);
        await _firestore
            .collection("logs")
            .doc(userEmail)
            .set(logs.toMap(), SetOptions(merge: true));
      });
    } catch (e) {
      await _firestore
          .collection("logs")
          .doc("admin")
          .get()
          .then((value) async {
        var logs = Logs.fromMap(value.data());
        var uuid = Uuid();
        log.logId = uuid.toString();
        log.userEmail = userEmail;
        logs.log.add(log);
        await _firestore
            .collection("logs")
            .doc("admin")
            .set(logs.toMap(), SetOptions(merge: true));
      });
    }
  }

  Future<bool> saveCourseCreate(HvsUser hvsUser) async {
    try {
      await _firestore
          .collection("users")
          .doc(hvsUser.email)
          .set(hvsUser.toMap(), SetOptions(merge: true));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
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

  Future<Course> getCourse(String courseName) async {
    Course _course;
    try {
      await _firestore.collection("course").doc(courseName).get().then((value) {
        _course = Course.fromMap(value.data());
      });

      return _course;
    } catch (e) {
      return null;
    }
  }

  Future<List<Course>> getCourseList() async {
    List<Course> _courseList = List<Course>();
    try {
      await _firestore.collection("course").get().then((courses) {
        courses.docs.forEach((course) {
          Course _course = Course();
          _course = Course.fromMap(course.data());
          _courseList.add(_course);
        });
      });

      return _courseList;
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
        var user = await getUser();
        if (map.containsValue(_loginUser) &&
            Constants.constants().contains(user.role)) {
          return true;
        } else {
          return false;
        }
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
      var lang = await PrefUtils.getLanguage();
      var result =
          await _firestore.collection("quat_of_images").doc(lang).get();
      map = result.data();
      return map;
    } catch (e) {
      print(e);
      return map;
    }
  }
}
