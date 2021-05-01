import 'dart:convert';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:notustohtml/notustohtml.dart';
import 'package:ntp/ntp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class DateAndNoteProvider with ChangeNotifier {
  DateAndNoteProvider(this._dateTime);
  DateTime _startDate;
  get startDate => this._startDate;

  set startDate(value) => this._startDate = value;

  DateTime _finishDate;
  get finishDate => this._finishDate;

  set finishDate(value) => this._finishDate = value;
  void setCourseDate(DateTime courseStartDate, DateTime courseFinishDate) {
    _startDate = courseStartDate;
    _finishDate = courseFinishDate;
  }

  DateTime _oldStartDate;
  get oldStartDate => this._oldStartDate;

  set oldStartDate(value) => this._oldStartDate = value;

  DateTime _oldFinishDate;
  get oldFinishDate => this._oldFinishDate;

  set oldFinishDate(value) => this._oldFinishDate = value;
  void setOldCourseDate(DateTime courseStartDate, DateTime courseFinishDate) {
    _oldStartDate = courseStartDate;
    _oldFinishDate = courseFinishDate;
  }

  DateTime _realTime;
  DateTime get realTime => this._realTime;

  set realTime(DateTime value) => this._realTime = value;
  Future<DateTime> getRealTime() async {
    DateTime _myTime = DateTime.now();
    final int offset = await NTP.getNtpOffset(
        localTime: _myTime, lookUpAddress: 'time.google.com');
    var _ntpTime = _myTime.add(Duration(milliseconds: offset));
    _realTime = _ntpTime;
    return _ntpTime;
  }

  DateTime _dateTime;
  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    if (value != null) {
      _dateTime = value;
    }
  }

  DateTime _oldDateTime;
  DateTime get oldDateTime => _oldDateTime;

  set oldDateTime(DateTime value) {
    if (value != null) {
      _oldDateTime = value;
    }
  }

  ZefyrController _zefryController;
  ZefyrController get zefryController => _zefryController;
  set zefryController(ZefyrController value) {
    if (value != null) {
      _zefryController = value;
    }
  }

  String _htmlNote;
  String get htmlNote => _htmlNote;
  set htmlNote(String value) {
    if (value != null) {
      _htmlNote = value;
    }
  }

  String _htmlOldNote;
  String get htmlOldNote => _htmlOldNote;
  set htmlOldNote(String value) {
    if (value != null) {
      _htmlOldNote = value;
    }
  }

  void setDate(DateTime date, String courseName) {
    _dateTime = date;
    setStringHtmlFromNote(courseName);
    notifyListeners();
  }

  void setOldDate(DateTime date, String courseName) {
    _oldDateTime = date;
    setOldStringHtmlFromNote(date, courseName);
    notifyListeners();
  }

  FocusNode setZefryFocusNode() {
    FocusNode _focusNode = FocusNode();
    return _focusNode;
  }

  void setZefryController(String courseName) async {
    var document = await _loadDocument(courseName);
    _zefryController = ZefyrController(document);
    notifyListeners();
  }

  bool _isDocumentCreate = false;
  Future<NotusDocument> _loadDocument(String courseName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(directory.path +
          "/note_${courseName}_${_dateTime.day.toString() + _dateTime.month.toString() + _dateTime.year.toString()}.json");
      if (await file.exists()) {
        final contents = await file.readAsString();
        _isDocumentCreate = true;
        return NotusDocument.fromJson(jsonDecode(contents));
      }
      final Delta delta = Delta()..insert("\n");
      _isDocumentCreate = false;
      return NotusDocument.fromDelta(delta);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  bool _isOldDocumentCreate = false;
  Future<NotusDocument> _loadOldDocument(
      DateTime date, String courseName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(directory.path +
          "/note_${courseName}_${date.day.toString() + date.month.toString() + date.year.toString()}.json");
      if (await file.exists()) {
        final contents = await file.readAsString();
        _isOldDocumentCreate = true;
        return NotusDocument.fromJson(jsonDecode(contents));
      }
      final Delta delta = Delta()..insert("\n");
      _isOldDocumentCreate = false;
      return NotusDocument.fromDelta(delta);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void saveNote(BuildContext context, ZefyrController _controller,
      String courseName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final contents = jsonEncode(_controller.document);
      final file = File(directory.path +
          "/note_${courseName}_${_dateTime.day.toString() + _dateTime.month.toString() + _dateTime.year.toString()}.json");
      file.writeAsString(contents).then((_) {
        NotificationWidget.showNotification(context, "Your Note is saved.");
      });
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  void setStringHtmlFromNote(String courseName) async {
    var document = await _loadDocument(courseName);
    if (document != null && _isDocumentCreate == true) {
      var _converter = NotusHtmlCodec();
      _htmlNote = _converter.encode(document.toDelta());
    } else if (document != null && _isDocumentCreate == false) {
      _htmlNote = null;
    }
    getLanguage();
    notifyListeners();
  }

  void setOldStringHtmlFromNote(DateTime date, String courseName) async {
    var document = await _loadOldDocument(date, courseName);
    if (document != null && _isOldDocumentCreate == true) {
      var _converter = NotusHtmlCodec();
      _htmlOldNote = _converter.encode(document.toDelta());
    } else if (document != null && _isOldDocumentCreate == false) {
      _htmlOldNote = null;
    }
    getLanguage();
    notifyListeners();
  }

  String _lang = 'en';
  String get lang => this._lang;

  set lang(String value) => this._lang = value;
  void getLanguage() async {
    _lang = await PrefUtils.getLanguage();
  }

  Future<bool> downloadPdfDocument(String courseName) async {
    String path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);

    var document = await _loadDocument(courseName);
    if (document != null && _isDocumentCreate == true) {
      var _converter = NotusHtmlCodec();
      _htmlNote = _converter.encode(document.toDelta());
      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          _htmlNote,
          path,
          "Note ${AppLocalizations.getString(courseName)}_${_dateTime.day.toString() + _dateTime.month.toString() + _dateTime.year.toString()}");
      return generatedPdfFile.exists();
    }
    return false;
  }

  Future<bool> downloadOldPdfDocument(
      DateTime oldDateTime, String courseName) async {
    String path = "";
    if (Platform.isAndroid) {
      path = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
    } else if (Platform.isIOS) {
      var directory = await getLibraryDirectory();
      path = directory.path;
    }

    var document = await _loadOldDocument(oldDateTime, courseName);
    if (document != null && _isOldDocumentCreate == true && path != "") {
      var _converter = NotusHtmlCodec();
      _htmlNote = _converter.encode(document.toDelta());
      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          _htmlNote,
          path,
          "Note ${AppLocalizations.getString(courseName)}_${oldDateTime.day.toString() + oldDateTime.month.toString() + oldDateTime.year.toString()}");
      return generatedPdfFile.exists();
    }
    return false;
  }
}
