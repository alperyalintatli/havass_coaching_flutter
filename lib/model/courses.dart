import 'dart:ffi';

class Course {
  Course({
    String courseName,
    String courseComment,
    List<DatesToPdf> dates,
  }) {
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

  List<DatesToPdf> _dates;
  List<DatesToPdf> get dates => this._dates;
  set dates(List<DatesToPdf> value) => this._dates = value;

  factory Course.fromMap(Map<String, dynamic> data) => Course(
        courseName: data["courseName"],
        courseComment: data["courseComment"],
        dates: data['dates'] != null
            ? (data['dates'] as List)
                .map((data) => DatesToPdf.fromMap(data))
                .toList()
            : null,
      );

  Map<String, dynamic> toMap() => {
        "courseName": this._courseName,
        "courseComment": this._courseComment,
        "dates": this._dates != null
            ? this._dates.map((e) {
                return {
                  "date": e.date,
                  "pdfName": e.pdfName,
                };
              }).toList()
            : null
      };
}

class DatesToPdf {
  DatesToPdf({String date, String pdfName}) {
    this._date = date;
    this._pdfName = pdfName;
  }
  String _date;
  String get date => this._date;

  set date(String value) => this._date = value;

  String _pdfName;
  String get pdfName => this._pdfName;

  set pdfName(String value) => this._pdfName = value;

  factory DatesToPdf.fromMap(Map<String, dynamic> data) => DatesToPdf(
        date: data["date"],
        pdfName: data["pdfName"],
      );

  Map<String, dynamic> toMap() => {
        "date": this._date,
        "pdfName": this._pdfName,
      };
}
