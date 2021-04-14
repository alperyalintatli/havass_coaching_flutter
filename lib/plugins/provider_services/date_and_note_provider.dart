import 'dart:convert';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:notustohtml/notustohtml.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class DateAndNoteProvider with ChangeNotifier {
  LoginOperations _loginOperation = LoginOperations.getInstance();

  DateAndNoteProvider(this._dateTime);
  DateTime _startDate;
  DateTime startDate() {
    return _startDate;
  }

  void getStartDate(DateTime courseStartDate) {
    _startDate = courseStartDate;
  }

  DateTime _dateTime;
  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    if (value != null) {
      _dateTime = value;
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

  DateTime finishDate() {
    return _startDate.add(Duration(days: 23));
  }

  void setDate(DateTime date) {
    _dateTime = date;
    setStringHtmlFromNote();
    notifyListeners();
  }

  FocusNode setZefryFocusNode() {
    FocusNode _focusNode = FocusNode();
    return _focusNode;
  }

  void setZefryController() async {
    var document = await _loadDocument();
    _zefryController = ZefyrController(document);
    notifyListeners();
  }

  bool _isDocumentCreate = false;
  Future<NotusDocument> _loadDocument() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(directory.path +
          "/note_${_dateTime.day.toString() + _dateTime.month.toString() + _dateTime.year.toString()}.json");
      if (await file.exists()) {
        final contents = await file.readAsString();
        _isDocumentCreate = true;
        return NotusDocument.fromJson(jsonDecode(contents));
      }
      final Delta delta = Delta()
        ..insert(
            "Hello ${_loginOperation.getLoginUserEmail()} :)  You can write for ${_dateTime.day}/${_dateTime.month}/${_dateTime.year}\n");
      _isDocumentCreate = false;
      return NotusDocument.fromDelta(delta);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void saveNote(BuildContext context, ZefyrController _controller) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final contents = jsonEncode(_controller.document);
      final file = File(directory.path +
          "/note_${_dateTime.day.toString() + _dateTime.month.toString() + _dateTime.year.toString()}.json");
      file.writeAsString(contents).then((_) {
        NotificationWidget.showNotification(context, "Your Note is saved.");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void setStringHtmlFromNote() async {
    var document = await _loadDocument();
    if (document != null && _isDocumentCreate == true) {
      var _converter = NotusHtmlCodec();
      _htmlNote = _converter.encode(document.toDelta());
    } else if (document != null && _isDocumentCreate == false) {
      _htmlNote = null;
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

  void downloadPdfDocument() async {
    String path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);

    var document = await _loadDocument();
    if (document != null && _isDocumentCreate == true) {
      var _converter = NotusHtmlCodec();
      _htmlNote = _converter.encode(document.toDelta());

      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          _htmlNote, path, "deneme");
      print(generatedPdfFile.exists());
    }
  }
}
