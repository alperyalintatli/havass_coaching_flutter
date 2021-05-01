import 'package:flutter_html/flutter_html.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/note_page.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';
import 'package:havass_coaching_flutter/widget/course_page/box_of_day.dart';
import 'package:havass_coaching_flutter/widget/popup_calendar.dart';
import 'package:havass_coaching_flutter/widget/settings_drawer_widget.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PastCoursePage extends StatefulWidget {
  @override
  _PastCoursePageState createState() => _PastCoursePageState();
}

class _PastCoursePageState extends State<PastCoursePage> {
  DateAndNoteProvider _dateProvider;
  int value = 0;

  void setNoteOfHtml() {
    if (value == 0) {
      _dateProvider.setStringHtmlFromNote();
      value++;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dateProvider = Provider.of<DateAndNoteProvider>(context);
    HvsUserProvider _hvsUserProvider =
        Provider.of<HvsUserProvider>(context, listen: false);
    setNoteOfHtml();
    final Widget zefryNote = (_dateProvider.htmlNote == null)
        ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NotePage())),
                  child: Text(
                    "How are you feeling :)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.handPointUp,
                    color: Colors.grey,
                  ),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NotePage())),
                ),
              ],
            ),
          )
        : Container(
            child: Column(
              children: [
                Html(data: _dateProvider.htmlNote),
                IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NotePage())),
                    icon: Icon(
                      Icons.edit,
                      color: Color.fromRGBO(164, 233, 232, 1),
                    ))
              ],
            ),
          );
    return Scaffold(
      endDrawer: SettingsDrawerWidget(),
      appBar: AppBarWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset("images/link.png"),
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                width: 30,
                height: 30,
                child: Image.asset("images/instagram.png"),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () async {
                  const url = 'https://t.me/TurkiyeSonDakika/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset("images/telegram.png"),
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () async {
                  const url = 'mailto:havassacademy@gmail.com';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset("images/email.png"),
                ),
              ),
              label: ""),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                child: Center(
                    child: Text(
                  AppLocalizations.getString(
                      _hvsUserProvider.selectedUserCourse.courseIdName),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: Colors.blueGrey.shade500),
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
                                '${DateFormat("dd, MMM").format(_dateProvider.startDate)} - ${DateFormat("dd, MMM").format(_dateProvider.finishDate)}',
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
                initialDate: _dateProvider.startDate,
                firstDate: _dateProvider.startDate,
                lastDate: _dateProvider.finishDate,
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
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Card(
                elevation: 16,
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: zefryNote,
                        ),
                      ],
                    ),
                  ),
                ),
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
              ),
              height: 300,
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
        minimumDate: _dateProvider.startDate,
        initialEndDate: _dateProvider.finishDate,
        initialStartDate: _dateProvider.startDate,
        maximumDate: _dateProvider.finishDate,
        onCancelClick: () {},
      ),
    );
  }
}