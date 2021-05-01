import 'dart:ffi';

class Course {
  Course({
    String courseId,
    String courseName,
    String courseComment,
    String registerDate,
    String terminationDate,
    String coursePrice,
    String courseDay,
    String courseIdName,
    List<DatesToPdf> dates,
  }) {
    this._courseId = courseId;
    this._courseName = courseName;
    this._courseComment = courseComment;
    this._registerDate = registerDate;
    this._terminationDate = terminationDate;
    this._coursePrice = coursePrice;
    this._courseDay = courseDay;
    this._courseIdName = courseIdName;
    this._dates = dates;
  }

  String _courseId;
  String get courseId => this._courseId;
  set courseId(String value) => this._courseId = value;

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

  String _courseDay;
  String get courseDay => this._courseDay;
  set courseDay(String value) => this._courseDay = value;

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

  String _coursePrice;
  String get coursePrice => this._coursePrice;
  set coursePrice(String value) => this._coursePrice = value;

  String _courseIdName;
  String get courseIdName => this._courseIdName;
  set courseIdName(String value) => this._courseIdName = value;

  List<DatesToPdf> _dates;
  List<DatesToPdf> get dates => this._dates;
  set dates(List<DatesToPdf> value) => this._dates = value;

  factory Course.fromMap(Map<String, dynamic> data) => Course(
        courseId: data["courseId"],
        courseName: data["courseName"],
        courseComment: data["courseComment"],
        registerDate: data["registerDate"],
        terminationDate: data["terminationDate"],
        coursePrice: data["coursePrice"],
        courseDay: data["courseDay"],
        courseIdName: data["courseIdName"],
        dates: data['dates'] != null
            ? (data['dates'] as List)
                .map((data) => DatesToPdf.fromMap(data))
                .toList()
            : null,
      );

  Map<String, dynamic> toMap() => {
        "courseId": this._courseId,
        "courseName": this._courseName,
        "courseComment": this._courseComment,
        "registerDate": this._registerDate,
        "terminationDate": this._terminationDate,
        "coursePrice": this._coursePrice,
        "courseDay": this._courseDay,
        "courseIdName": this._courseIdName,
        "dates": this._dates != null
            ? this._dates.map((e) {
                return {
                  "date": e.date,
                  "enPdfName": e.enPdfName,
                  "dePdfName": e.dePdfName
                };
              }).toList()
            : null
      };
}

class DatesToPdf {
  DatesToPdf({String date, String enPdfName, String dePdfName}) {
    this._date = date;
    this._enPdfName = enPdfName;
    this._dePdfName = dePdfName;
  }
  String _date;
  String get date => this._date;

  set date(String value) => this._date = value;

  String _enPdfName;
  String get enPdfName => this._enPdfName;

  set enPdfName(String value) => this._enPdfName = value;

  String _dePdfName;
  String get dePdfName => this._dePdfName;

  set dePdfName(String value) => this._dePdfName = value;

  factory DatesToPdf.fromMap(Map<String, dynamic> data) => DatesToPdf(
      date: data["date"],
      enPdfName: data["enPdfName"],
      dePdfName: data["dePdfName"]);

  Map<String, dynamic> toMap() => {
        "date": this._date,
        "enPdfName": this._enPdfName,
        "dePdfName": this._dePdfName
      };
}
