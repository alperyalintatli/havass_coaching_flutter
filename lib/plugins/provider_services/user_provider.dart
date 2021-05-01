import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/model/courses.dart';
import 'package:havass_coaching_flutter/model/users.dart';
import 'package:havass_coaching_flutter/plugins/firebase_database_services/firebase_database_operations.dart';
import 'package:ntp/ntp.dart';

class HvsUserProvider with ChangeNotifier {
  DatabaseOperation _databaseOperation = DatabaseOperation.getInstance();
  HvsUser _hvsUser;
  HvsUser get getHvsUser {
    return this._hvsUser;
  }

  set setHvsUser(HvsUser hvsUser) => this._hvsUser = _hvsUser;

  Future<void> getUser({HvsUser hvsUser}) async {
    this._hvsUser = await _databaseOperation.getUser(hvsUser: hvsUser);
    if (_hvsUser != null) {
      _checkRole();
    }
    notifyListeners();
  }

  Future<bool> createCourse(HvsUser hvsUser) async {
    var result = await _databaseOperation.saveCourseCreate(hvsUser);
    return result;
  }

  Course selectedUserCourse = Course();
  void getUserCourse(Course userCourse) {
    selectedUserCourse = userCourse;
    notifyListeners();
  }

  Future<Course> getCourse(String courseName) async {
    var result = await _databaseOperation.getCourse(courseName);
    return result;
  }

  Course course16 = Course();
  void getCourse16() async {
    course16 = await _databaseOperation.getCourse(Constants.COURSE_OF_16);
    notifyListeners();
  }

  Course course28 = Course();
  void getCourse28() async {
    course28 = await _databaseOperation.getCourse(Constants.COURSE_OF_28);
    notifyListeners();
  }

  Future<bool> changeUserName(String userName) async {
    bool result = await _databaseOperation.changeUserName(userName);
    getUser();
    return result;
  }

  Future<bool> addManuelStudent(String email, String courseName) async {
    try {
      if (getIsAdmin) {
        HvsUser hvsUser = HvsUser();
        hvsUser.email = email;
        bool result = await saveManuelCourse(courseName, hvsUser: hvsUser);
        return result;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<HvsUser> getManuelUser({HvsUser hvsUser}) async {
    var manuelUser = await _databaseOperation.getUser(hvsUser: hvsUser);
    if (manuelUser != null) {
      return manuelUser;
    }
    return null;
  }

  Future<bool> saveManuelCourse(String productId, {HvsUser hvsUser}) async {
    try {
      var manuelUser = await getManuelUser(hvsUser: hvsUser);
      if (manuelUser == null) {
        return false;
      }
      DateTime _myTime = DateTime.now();
      final int offset = await NTP.getNtpOffset(
          localTime: _myTime, lookUpAddress: 'time.google.com');
      var _ntpTime = _myTime.add(Duration(milliseconds: offset));
      var courseDescp = await getCourse(productId);
      if (courseDescp != null) {
        Course course = Course();
        course.courseName = courseDescp.courseName;
        course.courseComment = courseDescp.courseComment;
        course.courseId = courseDescp.courseId;
        String registerDate = _ntpTime.day.toString() +
            "." +
            _ntpTime.month.toString() +
            "." +
            _ntpTime.year.toString();
        course.setRegisterDate = registerDate;
        course.coursePrice = courseDescp.coursePrice;
        course.courseDay = courseDescp.courseDay;
        course.courseIdName = courseDescp.courseIdName;
        List<DatesToPdf> listDates = List<DatesToPdf>();
        var dateTime = _ntpTime;
        for (var i = 0; i < int.parse(courseDescp.courseDay) + 1; i++) {
          DatesToPdf datesToPdf = DatesToPdf();
          String date = dateTime.day.toString() +
              "." +
              dateTime.month.toString() +
              "." +
              dateTime.year.toString();
          datesToPdf.date = date;
          datesToPdf.enPdfName =
              courseDescp.courseIdName + "_" + "en" + "_" + i.toString();
          datesToPdf.dePdfName =
              courseDescp.courseIdName + "_" + "de" + "_" + i.toString();
          listDates.add(datesToPdf);
          if (int.parse(courseDescp.courseDay) == i) {
            course.setTerminationDate = date;
          }
          dateTime = dateTime.add(Duration(days: 1));
        }

        course.dates = listDates;
        // List<Course> course = List<Course>();
        // course.add(course1);
        manuelUser.course.add(course);
        await createCourse(manuelUser);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
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

  Future<bool> saveCourse(String productId, {HvsUser hvsUser}) async {
    try {
      await getUser(hvsUser: hvsUser);
      if (getHvsUser == null) {
        return false;
      }
      DateTime _myTime = DateTime.now();
      final int offset = await NTP.getNtpOffset(
          localTime: _myTime, lookUpAddress: 'time.google.com');
      var _ntpTime = _myTime.add(Duration(milliseconds: offset));
      var courseDescp = await getCourse(productId);
      if (courseDescp != null) {
        Course course = Course();
        course.courseName = courseDescp.courseName;
        course.courseComment = courseDescp.courseComment;
        course.courseId = courseDescp.courseId;
        String registerDate = _ntpTime.day.toString() +
            "." +
            _ntpTime.month.toString() +
            "." +
            _ntpTime.year.toString();
        course.setRegisterDate = registerDate;
        course.coursePrice = courseDescp.coursePrice;
        course.courseDay = courseDescp.courseDay;
        course.courseIdName = courseDescp.courseIdName;
        List<DatesToPdf> listDates = List<DatesToPdf>();
        var dateTime = _ntpTime;
        for (var i = 0; i < int.parse(courseDescp.courseDay) + 1; i++) {
          DatesToPdf datesToPdf = DatesToPdf();
          String date = dateTime.day.toString() +
              "." +
              dateTime.month.toString() +
              "." +
              dateTime.year.toString();
          datesToPdf.date = date;
          datesToPdf.enPdfName =
              courseDescp.courseIdName + "_" + "en" + "_" + i.toString();
          datesToPdf.dePdfName =
              courseDescp.courseIdName + "_" + "de" + "_" + i.toString();
          listDates.add(datesToPdf);
          if (int.parse(courseDescp.courseDay) == i) {
            course.setTerminationDate = date;
          }
          dateTime = dateTime.add(Duration(days: 1));
        }

        course.dates = listDates;
        // List<Course> course = List<Course>();
        // course.add(course1);
        getHvsUser.course.add(course);
        await createCourse(getHvsUser);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
