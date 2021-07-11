import 'dart:convert';
import 'dart:io';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:ntp/ntp.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;

class DateAndNoteProvider with ChangeNotifier {
  DateAndNoteProvider(this._dateTime);
  DateTime _startDate;
  get startDate => this._startDate;

  set startDate(value) => this._startDate = value;

  DateTime _finishDate;
  DateTime get finishDate => this._finishDate;

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

  /*ZefyrController _zefryController;
  ZefyrController get zefryController => _zefryController;
  set zefryController(ZefyrController value) {
    if (value != null) {
      _zefryController = value;
    }
  }*/

  QuillController _quillController;
  QuillController get quillController => _quillController;
  set quillController(QuillController value) {
    if (value != null) {
      _quillController = value;
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
    if(document != null){
      _quillController = QuillController(
          document: document,
          selection: const TextSelection.collapsed(offset: 0)
      );
      notifyListeners();
    }
  }

  bool _isDocumentCreate = false;
  Future<Document> _loadDocument(String courseName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(directory.path +
          "/note_${courseName}_${_dateTime.day.toString() + _dateTime.month.toString() + _dateTime.year.toString()}.json");
      if (await file.exists()) {
        final contents = await file.readAsString();
        _isDocumentCreate = true;
        return Document.fromJson(jsonDecode(contents));
      }
      //final Delta delta = Delta()..insert("\n");
      _isDocumentCreate = false;
      return Document();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  bool _isOldDocumentCreate = false;
  Future<Document> _loadOldDocument(
      DateTime date, String courseName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(directory.path +
          "/note_${courseName}_${date.day.toString() + date.month.toString() + date.year.toString()}.json");
      if (await file.exists()) {
        final contents = await file.readAsString();
        _isOldDocumentCreate = true;
        return Document.fromJson(jsonDecode(contents));
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void saveNote(BuildContext context, /*ZefyrController _controller,*/QuillController _controller,
      String courseName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      var contents = jsonEncode(_controller.document.toDelta().toJson());
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
    var document  = await _loadDocument(courseName);
    if (document != null && _isDocumentCreate == true) {
      //var _converter /*= NotusHtmlCodec()*/;
      //_htmlNote = _converter.encode(document.toDelta());
      _quillController = QuillController(
          document: document,
          selection: const TextSelection.collapsed(offset: 0)
      );

    } else if (document != null && _isDocumentCreate == false) {
      _quillController = null;
      //_htmlNote = null;
    }
    getLanguage();
    notifyListeners();
  }

  void setOldStringHtmlFromNote(DateTime date, String courseName) async {
    var document = await _loadOldDocument(date, courseName);
    if (document != null && _isOldDocumentCreate == true) {
      //var _converter /*= NotusHtmlCodec()*/;
      //_htmlOldNote = _converter.encode(document.toDelta());
      _quillController = QuillController(
          document: document,
          selection: const TextSelection.collapsed(offset: 0)
      );
    } else if (document != null && _isOldDocumentCreate == false) {
      //_htmlOldNote = null;
      _quillController = null;
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
    //String path = await ExtStorage.getExternalStoragePublicDirectory(
    //ExtStorage.DIRECTORY_DOWNLOADS);
    var permission = await Permission.storage.request();
    if (!permission.isDenied) {
      Directory path;
      if (Platform.isAndroid) {
        path = await getApplicationDocumentsDirectory();
        //path = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        path = await getLibraryDirectory();
      }
      var document = await _loadDocument(courseName);
      if (document != null && _isDocumentCreate == true) {
        _quillController = QuillController(
            document: document,
            selection: const TextSelection.collapsed(offset: 0)
        );
        var value = quillController.plainTextEditingValue.text;
        final pdf = pw.Document();
        pdf.addPage(pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Container(
                child:pw.Text(value)
              ); // Center
            }));
        var file = File(path.path+"/Note ${AppLocalizations.getString(courseName)}_${_dateTime.day
            .toString() + _dateTime.month.toString() +
            _dateTime.year.toString()}.pdf");
        try{
          await file.writeAsBytes(await pdf.save());
          OpenFile.open(file.path);
        }
        catch(ex){
          print(ex);
        }

        //_htmlNote = _converter.encode(document.toDelta());
        /*var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
            _htmlNote,
            path.path,
            "Note ${AppLocalizations.getString(courseName)}_${_dateTime.day
                .toString() + _dateTime.month.toString() +
                _dateTime.year.toString()}");
        return generatedPdfFile.exists();*/
        return true;
      }
      return false;
    }
  }

    Future<bool> downloadOldPdfDocument(DateTime oldDateTime,
        String courseName) async {
      var permission = await Permission.storage.request();
      if (!permission.isDenied) {
        Directory path;
        if (Platform.isAndroid) {
          path = await getApplicationDocumentsDirectory();
          //path = await getExternalStorageDirectory();
        } else if (Platform.isIOS) {
          path = await getLibraryDirectory();
        }

      var document = await _loadOldDocument(oldDateTime, courseName);
      if (document != null && _isOldDocumentCreate == true && path != "") {

        _quillController = QuillController(
            document: document,
            selection: const TextSelection.collapsed(offset: 0)
        );
        var value = quillController.plainTextEditingValue.text;
        final pdf = pw.Document();
        pdf.addPage(pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Container(
                  child:pw.Text(value)
              ); // Center
            }));
        var file = File(path.path+"/Note ${AppLocalizations.getString(courseName)}_${_oldDateTime.day
            .toString() + _oldDateTime.month.toString() +
            _oldDateTime.year.toString()}.pdf");
        try{
          await file.writeAsBytes(await pdf.save());
          OpenFile.open(file.path);
        }
        catch(ex){
          print(ex);
        }
        /*var _converter /*= NotusHtmlCodec()*/;
        _htmlNote = _converter.encode(document.toDelta());
        var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
            _htmlNote,
            path,
            "Note ${AppLocalizations.getString(courseName)}_${oldDateTime.day
                .toString() + oldDateTime.month.toString() +
                oldDateTime.year.toString()}");
        return generatedPdfFile.exists();*/
      }
      return false;
    }
  }
}
