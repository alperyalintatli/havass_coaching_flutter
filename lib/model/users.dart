import 'package:havass_coaching_flutter/model/courses.dart';

class HvsUser {
  HvsUser(
      {String userName,
      String email,
      String password,
      String role,
      List<Course> course}) {
    this._userName = userName;
    this._email = email;
    this._password = password;
    this._course = course;
    this._role = role;
  }
  String _userName;
  String get name => _userName;
  set name(String value) {
    if (value != null) {
      _userName = value;
    }
  }

  String _email;
  String get email => _email;

  set email(String value) {
    if (value != null) {
      _email = value;
    }
  }

  String _password;
  String get password => _password;
  set password(String value) {
    if (value != null) {
      _password = value;
    }
  }

  String _role;
  String get role => this._role;
  set role(String value) => this._role = value;

  String _adress;
  String get adress => this._adress;
  set adress(String value) => this._adress = value;

  String _telNumber;
  String get telNumber => this._telNumber;
  set telNumber(String value) => this._telNumber = value;

  List<Course> _course;
  List<Course> get course => this._course;

  set course(List<Course> value) => this._course = value;
  Map map = Map();

  factory HvsUser.fromMap(Map<String, dynamic> data) => HvsUser(
        userName: data["userName"],
        email: data["email"],
        role: data["role"],
        course: data['course'] != null
            ? (data['course'] as List)
                .map((data) => Course.fromMap(data))
                .toList()
            : null,
      );

  Map<String, dynamic> toMap() => {
        "userName": this._userName,
        "email": this._email,
        "role": this._role,
        "course": this._course != null
            ? this._course.map((e) {
                return {
                  "courseName": e.courseName,
                  "courseComment": e.courseComment,
                  "dates": e.dates.map((t) {
                    return {
                      "date": t.date,
                      "pdfName": t.pdfName,
                    };
                  }).toList()
                };
              }).toList()
            : null
      };
}
