import 'dart:convert';
import 'dart:io';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class DateAndNoteProvider with ChangeNotifier {
  LoginOperations _loginOperation = LoginOperations.getInstance();
  DateTime _dateTime;
  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    if (value != null) {
      _dateTime = value;
    }
  }

  DateAndNoteProvider(this._dateTime);
  DateTime _startDate;
  DateTime startDate() {
    _startDate = DateTime(2021, 2, 12);
    return _startDate;
  }

  DateTime finishDate() {
    return _startDate.add(Duration(days: 23));
  }

  void setDate(DateTime date) {
    _dateTime = date;
    notifyListeners();
  }

  FocusNode setZefryFocusNode() {
    FocusNode _focusNode = FocusNode();
    return _focusNode;
  }

  ZefyrController _zefryController;
  ZefyrController get zefryController => _zefryController;
  set zefryController(ZefyrController value) => _zefryController = value;

  void setZefryController() async {
    var document = await loadDocument();
    _zefryController = ZefyrController(document);
    notifyListeners();
  }

  Future<NotusDocument> loadDocument() async {
    try {
      final file = File(Directory.systemTemp.path +
          "/note_${_dateTime.day + _dateTime.month + _dateTime.year}.json");
      if (await file.exists()) {
        final contents = await file.readAsString();
        return NotusDocument.fromJson(jsonDecode(contents));
      }
      final Delta delta = Delta()
        ..insert(
            "Hello ${_loginOperation.getLoginName()} :)  You can write for ${_dateTime.day}/${_dateTime.month}/${_dateTime.year}\n");
      return NotusDocument.fromDelta(delta);
    } catch (e) {
      print(e.toString());
    }
  }

  void saveNote(BuildContext context, ZefyrController _controller) {
    final contents = jsonEncode(_controller.document);
    final file = File(Directory.systemTemp.path +
        "/note_${_dateTime.day + _dateTime.month + _dateTime.year}.json");
    file.writeAsString(contents).then((_) {
      NotificationWidget.showNotification(context, "Your Note is saved.");
    });
  }
}
