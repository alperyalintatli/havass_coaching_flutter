import 'dart:convert';
import 'dart:io';
import 'package:quill_delta/quill_delta.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class DateTimeProvider with ChangeNotifier {
  DateTime _dateTime;
  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    if (value != null) {
      _dateTime = value;
    }
  }

  DateTimeProvider(this._dateTime);
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

  Future<ZefyrController> setZefryController() async {
    final document = await _loadDocument();
    ZefyrController _controller = ZefyrController(document);
    return _controller;
  }

  Future<NotusDocument> _loadDocument() async {
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    if (await file.exists()) {
      final contents = await file.readAsString();
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

  ZefyrController setEmptyZefryController() {
    final document = _loadEmptyDocument();
    ZefyrController _controller = ZefyrController(document);
    return _controller;
  }

  NotusDocument _loadEmptyDocument() {
    final Delta delta = Delta()
      ..insert(
          "Hello Yalın :)  You can write for ${_dateTime.day}/${_dateTime.month}/${_dateTime.year}\n");
    return NotusDocument.fromDelta(delta);
  }

  void saveNote(BuildContext context, ZefyrController _controller) {
    final contents = jsonEncode(_controller.document);
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    file.writeAsString(contents).then((_) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
    });
  }
}
