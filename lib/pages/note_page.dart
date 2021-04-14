import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:provider/provider.dart';
import 'package:zefyr/zefyr.dart';

class NotePage extends StatefulWidget {
  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
  DateAndNoteProvider _noteProvider;
  int value = 0;

  @override
  Widget build(BuildContext context) {
    _noteProvider = Provider.of<DateAndNoteProvider>(context);
    setZefryController();
    final Widget zefryEditor = (_noteProvider.zefryController == null)
        ? Center(child: CircularProgressIndicator())
        : ZefyrScaffold(
            child: ZefyrEditor(
              padding: EdgeInsets.all(16),
              autofocus: false,
              controller: _noteProvider.zefryController,
              focusNode: _noteProvider.setZefryFocusNode(),
            ),
          );
    return Scaffold(
      appBar: AppBar(
        title: Text("Editor page"),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  _noteProvider.saveNote(
                      context, _noteProvider.zefryController);
                  _noteProvider.setStringHtmlFromNote();
                  Navigator.pop(context);
                }),
          )
        ],
      ),
      body: zefryEditor,
    );
  }

  void setZefryController() {
    if (value == 0) {
      _noteProvider.setZefryController();
      value++;
    }
  }
}
