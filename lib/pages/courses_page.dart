import 'package:flutter_html/flutter_html.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/course_pdf_page.dart';
import 'package:havass_coaching_flutter/pages/note_page.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';
import 'package:havass_coaching_flutter/widget/popup_calendar.dart';
import 'package:havass_coaching_flutter/widget/settings_drawer_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  DateAndNoteProvider _dateProvider;
  HvsUserProvider _hvsUserProvider;
  int value = 0;

  void setNoteOfHtml() {
    if (value == 0) {
      _dateProvider.setStringHtmlFromNote();
      value++;
    }
  }

  @override
  Widget build(BuildContext context) {
    _dateProvider = Provider.of<DateAndNoteProvider>(context);
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    setNoteOfHtml();
    final Widget zefryNote = (_dateProvider.htmlNote == null)
        ? IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NotePage())),
            icon: Icon(
              Icons.create_new_folder,
              color: Colors.blue,
            ))
        : Container(
            child: Column(
              children: [
                Html(data: _dateProvider.htmlNote),
                IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NotePage())),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ))
              ],
            ),
          );
    return Scaffold(
      endDrawer: SettingsDrawerWidget(),
      appBar: AppBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String pdfName;
          for (var i = 0; i < _hvsUserProvider.getHvsUser.course.length; i++) {
            for (var j = 0;
                j < _hvsUserProvider.getHvsUser.course[i].dates.length;
                j++) {
              String date = DateTime.now().day.toString() +
                  "." +
                  DateTime.now().month.toString() +
                  "." +
                  DateTime.now().year.toString();
              if (_hvsUserProvider.getHvsUser.course[i].dates[j].date == date) {
                pdfName =
                    _hvsUserProvider.getHvsUser.course[i].dates[j].pdfName;
              }
            }
          }

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CoursePdf(pdfName)));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(164, 233, 232, 1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        child: Container(
            child: Column(
          children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 1.5,
                                    blurRadius: 1.5,
                                    color: Colors.grey.withOpacity(0.6))
                              ],
                            ),
                            margin: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                '${DateFormat("dd, MMM").format(_dateProvider.startDate())} - ${DateFormat("dd, MMM").format(_dateProvider.finishDate())}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
            Container(
              height: 120,
              child: CalendarTimeline(
                initialDate: _dateProvider.dateTime,
                firstDate: _dateProvider.startDate(),
                lastDate: _dateProvider.finishDate(),
                onDateSelected: (date) {
                  _dateProvider.setDate(date);
                },
                leftMargin: 20,
                monthColor: Color.fromRGBO(164, 233, 232, 1),
                dayColor: Color.fromRGBO(164, 233, 232, 1),
                dayNameColor: Color(0xFF333A47),
                activeDayColor: Colors.white,
                activeBackgroundDayColor: Color.fromRGBO(164, 233, 232, 1),
                dotsColor: Color(0xFF333A47),
                // selectableDayPredicate: (date) => date.day != 23,
                locale: _dateProvider.lang,
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: zefryNote,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: const DecorationImage(
                  image: AssetImage('images/note_background.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void showDemoDialog({BuildContext context}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: _dateProvider.startDate(),
        initialEndDate: _dateProvider.finishDate(),
        initialStartDate: _dateProvider.startDate(),
        maximumDate: _dateProvider.finishDate(),
        onCancelClick: () {},
      ),
    );
  }
}
