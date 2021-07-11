import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:provider/provider.dart';
//import 'package:zefyr/zefyr.dart';

class NotePage extends StatefulWidget {
  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
      DateAndNoteProvider _noteProvider;
  HvsUserProvider _hvsUserProvider;
  int value = 0;

  @override
  Widget build(BuildContext context) {
    quill.QuillController( document: quill.Document(),
      selection: const TextSelection.collapsed(offset: 0),);
    _noteProvider = Provider.of<DateAndNoteProvider>(context);
    _hvsUserProvider = Provider.of<HvsUserProvider>(context, listen: false);
    setQuillController();
    final Widget quillEditor = (_noteProvider.quillController == null)
        ? Center(child: CircularProgressIndicator())
        :SingleChildScrollView(child:Column(
      children: [
        quill.QuillToolbar.basic(controller:_noteProvider.quillController,),
        Container(
          child: quill.QuillEditor.basic(
            controller: _noteProvider.quillController,
            readOnly: false,// true for view only mode
          ),
        ),

      ],
    ) ,)
    /*ZefyrScaffold(
            child: ZefyrEditor(
              padding: EdgeInsets.all(16),
              autofocus: false,
              controller: _noteProvider.zefryController,
              focusNode: _noteProvider.setZefryFocusNode(),
            ),
          )*/;
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            _noteProvider.setStringHtmlFromNote(
                _hvsUserProvider.selectedUserCourse.courseIdName);
              Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(164, 233, 232, 1),
        title:  Text(AppLocalizations.getString("editor_page_text")),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  _noteProvider.saveNote(context, _noteProvider.quillController,
                      _hvsUserProvider.selectedUserCourse.courseIdName);
                  _noteProvider.setStringHtmlFromNote(
                      _hvsUserProvider.selectedUserCourse.courseIdName);
                  Navigator.pop(context);
                }),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
          child:quillEditor),
    );
  }

  void setQuillController() {
    if (value == 0) {
     _noteProvider
          .setZefryController(_hvsUserProvider.selectedUserCourse.courseIdName);
      value++;
    }
  }
}
