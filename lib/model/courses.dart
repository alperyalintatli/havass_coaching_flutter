import 'dart:convert';
import 'dart:ffi';

class Course {
  Course({String courseName, String courseComment, Map<String, String> dates}) {
    this._courseName = courseName;
    this._courseComment = courseComment;
    this._dates = dates;
  }

  String _courseName;
  String get courseName => this._courseName;
  set courseName(String value) => this._courseName = value;

  String _registerDate;
  String get getRegisterDate => this._registerDate;
  set setRegisterDate(String registerDate) => this._registerDate = registerDate;

  String _terminationDate;
  String get getTerminationDate => this._terminationDate;
  set setTerminationDate(String terminationDate) =>
      this._terminationDate = terminationDate;

  bool _isCourseContinue;
  bool get isCourseContinue => this._isCourseContinue;
  set isCourseContinue(bool value) => this._isCourseContinue = value;

  bool _isCourseCancel;
  bool get isCourseCancel => this._isCourseCancel;
  set isCourseCancel(bool value) => this._isCourseCancel = value;

  String _cancelReason;
  String get cancelReason => this._cancelReason;
  set cancelReason(String value) => this._cancelReason = value;

  String _courseComment;
  String get courseComment => this._courseComment;
  set courseComment(String value) => this._courseComment = value;

  Double _courseRate;
  Double get courseRate => this._courseRate;
  set courseRate(Double value) => this._courseRate = value;

  Double _coursePrice;
  Double get coursePrice => this._coursePrice;
  set coursePrice(Double value) => this._coursePrice = value;

  Map<String, dynamic> _dates;
  Map<String, dynamic> get getDates => this._dates;

  set setDates(Map<String, dynamic> dates) => this._dates = dates;

  factory Course.fromMap(Map<String, dynamic> data) => Course(
      courseName: data["courseName"],
      courseComment: data["courseComment"],
      dates: data["dates"]);

  Map<String, dynamic> toMap() => {
        "courseName": this._courseName,
        "courseComment": this._courseComment,
        "dates": this._dates,
      };
}
