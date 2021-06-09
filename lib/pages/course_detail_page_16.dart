import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/pages/cart_page.dart';
import 'package:havass_coaching_flutter/pages/courses_page.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/cart_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:havass_coaching_flutter/widget/settings_drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:ntp/ntp.dart';

class CourseInfoScreen16 extends StatefulWidget {
  final bool likeIcon;
  CourseInfoScreen16({this.likeIcon});
  @override
  _CourseInfoScreen16State createState() => _CourseInfoScreen16State();
}

class _CourseInfoScreen16State extends State<CourseInfoScreen16>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  bool likeIcon;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();

    likeIcon = widget.likeIcon;
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  final Color _checkIconColor = Color.fromARGB(255, 0, 243, 245);
  CartProvider _cartProvider;
  HvsUserProvider _hvsUserProvider;
  DateAndNoteProvider _dateAndNoteProvider;
  double _starValue = 1.0;
  bool _isCourse = false;
  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    _dateAndNoteProvider = Provider.of<DateAndNoteProvider>(context);

    isGetCourse();
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width) +
        100.0;
    return Container(
      color: Colors.white,
      child: Scaffold(
        endDrawer: SettingsDrawerWidget(),
        appBar: AppBarWidget(),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.4,
                  child: Image.asset(
                    'images/' +
                        _hvsUserProvider.course16.courseIdName +
                        '_image.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.4) - 75.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 18, right: 16),
                            child: Text(
                              AppLocalizations.getString(
                                  _hvsUserProvider.course16.courseIdName),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: Color(0xFF17262A),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 5, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Text(
                                //   '€ ' + _hvsUserProvider.course16.coursePrice,
                                //   textAlign: TextAlign.left,
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 22,
                                //     letterSpacing: 0.27,
                                //     color: Color.fromRGBO(154, 206, 207, 1),
                                //   ),
                                // ),
                                getTimeBoxUI(
                                    _hvsUserProvider.course16.courseDay,
                                    AppLocalizations.getString("days")),
                                IconButton(
                                    icon: likeIcon
                                        ? FaIcon(
                                            FontAwesomeIcons.solidHeart,
                                            color: Color.fromARGB(
                                                255, 255, 132, 0),
                                          )
                                        : FaIcon(
                                            FontAwesomeIcons.heart,
                                            color: Color.fromARGB(
                                                255, 255, 132, 0),
                                          ),
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        if (!prefs
                                            .containsKey("Course_of_16_like")) {
                                          prefs.setBool(
                                              "Course_of_16_like", true);
                                          likeIcon = true;
                                        } else if (prefs
                                                .getBool("Course_of_16_like") ==
                                            false) {
                                          prefs.setBool(
                                              "Course_of_16_like", true);
                                          likeIcon = true;
                                        } else {
                                          prefs.setBool(
                                              "Course_of_16_like", false);
                                          likeIcon = false;
                                        }
                                      });
                                    }),

                                // Container(
                                //   child: Row(
                                //     children: <Widget>[
                                //       Container(
                                //         width: 75,
                                //         child: PopupMenuButton(
                                //             onCanceled: () {
                                //               NotificationWidget.showNotification(
                                //                   context,
                                //                   AppLocalizations.getString(
                                //                       "star_rating_notification"));
                                //             },
                                //             elevation: 8,
                                //             offset: Offset.lerp(Offset(30, 0),
                                //                 Offset(0, 4), 8.5),
                                //             captureInheritedThemes: true,
                                //             color: Color.fromRGBO(
                                //                 154, 206, 207, 1),
                                //             icon: Row(
                                //               children: [
                                //                 Text(
                                //                   '4.8',
                                //                   textAlign: TextAlign.left,
                                //                   style: TextStyle(
                                //                     fontWeight: FontWeight.w200,
                                //                     fontSize: 22,
                                //                     letterSpacing: 0.27,
                                //                     color: Colors.grey,
                                //                   ),
                                //                 ),
                                //                 Icon(
                                //                   Icons.star,
                                //                   color: Color.fromRGBO(
                                //                       154, 206, 207, 1),
                                //                   size: 24,
                                //                 ),
                                //               ],
                                //             ),
                                //             itemBuilder: (context) => [
                                //                   PopupMenuItem(
                                //                       child: Container(
                                //                           child:
                                //                               SmoothStarRating(
                                //                                   allowHalfRating:
                                //                                       true,
                                //                                   onRated: (v) {
                                //                                     setState(
                                //                                         () {
                                //                                       _starValue =
                                //                                           v;
                                //                                     });
                                //                                   },
                                //                                   starCount: 5,
                                //                                   rating:
                                //                                       _starValue,
                                //                                   size: 40.0,
                                //                                   isReadOnly:
                                //                                       false,
                                //                                   color: Colors
                                //                                       .white,
                                //                                   borderColor:
                                //                                       Colors
                                //                                           .white,
                                //                                   spacing:
                                //                                       0.0)),
                                //                       value: "/newchat"),
                                //                 ]),
                                //       ),
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 5, bottom: 15),
                                child: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLocalizations.getString(
                                              "course_16_description_1"),
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            height: 1.4,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            letterSpacing: 0.75,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidCheckCircle,
                                              color: _checkIconColor,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    AppLocalizations.getString(
                                                        "course_16_description_2"),
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.75,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidCheckCircle,
                                              color: _checkIconColor,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    AppLocalizations.getString(
                                                        "course_16_description_3"),
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.75,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidCheckCircle,
                                              color: _checkIconColor,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    AppLocalizations.getString(
                                                        "course_16_description_4"),
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.75,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidCheckCircle,
                                              color: _checkIconColor,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    AppLocalizations.getString(
                                                        "course_16_description_5"),
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.75,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          AppLocalizations.getString(
                                              "course_16_description_6"),
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            height: 1.4,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            letterSpacing: 0.75,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidCheckCircle,
                                              color: _checkIconColor,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    AppLocalizations.getString(
                                                        "course_16_description_7"),
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.75,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidCheckCircle,
                                              color: _checkIconColor,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    AppLocalizations.getString(
                                                        "course_16_description_8"),
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.75,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidCheckCircle,
                                              color: _checkIconColor,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    AppLocalizations.getString(
                                                        "course_16_description_9"),
                                                    style: TextStyle(
                                                      height: 1.4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.75,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          AppLocalizations.getString(
                                              "course_16_description_10"),
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            height: 1.4,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.75,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppLocalizations.getString(
                                                "course_16_description_11"),
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              height: 1.4,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.75,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          AppLocalizations.getString(
                                              "course_16_description_12"),
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            height: 1.4,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.75,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 2500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 5, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () async {
                                            if (_isCourse) {
                                              var realDateNow =
                                                  await _dateAndNoteProvider
                                                      .getRealTime();
                                              String nowDate = realDateNow.day
                                                      .toString() +
                                                  "." +
                                                  realDateNow.month.toString() +
                                                  "." +
                                                  realDateNow.year.toString();
                                              await _hvsUserProvider.getUser();
                                              var courseList = _hvsUserProvider
                                                  .getHvsUser.course
                                                  .where((element) =>
                                                      element.courseIdName ==
                                                      Constants.COURSE_OF_16)
                                                  .toList();
                                              courseList.forEach((course) {
                                                course.dates
                                                    .forEach((date) async {
                                                  if (date.date == nowDate) {
                                                    _hvsUserProvider
                                                        .getUserCourse(course);
                                                    var startDate =
                                                        _hvsUserProvider
                                                            .selectedUserCourse
                                                            .getRegisterDate
                                                            .split(".");
                                                    var finishDate =
                                                        _hvsUserProvider
                                                            .selectedUserCourse
                                                            .getTerminationDate
                                                            .split(".");
                                                    _dateAndNoteProvider.setCourseDate(
                                                        DateTime(
                                                            int.parse(startDate[
                                                                    2]
                                                                .toString()),
                                                            int.parse(
                                                                startDate[1]
                                                                    .toString()),
                                                            int.parse(startDate[
                                                                    0]
                                                                .toString())),
                                                        DateTime(
                                                            int.parse(
                                                                finishDate[2]
                                                                    .toString()),
                                                            int.parse(
                                                                finishDate[1]
                                                                    .toString()),
                                                            int.parse(finishDate[
                                                                    0]
                                                                .toString())));
                                                    DateTime _myTime =
                                                        DateTime.now();
                                                    final int offset =
                                                        await NTP.getNtpOffset(
                                                            localTime: _myTime,
                                                            lookUpAddress:
                                                                'time.google.com');
                                                    DateTime _ntpTime =
                                                        _myTime.add(Duration(
                                                            milliseconds:
                                                                offset));
                                                    _dateAndNoteProvider
                                                        .dateTime = _ntpTime;
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CoursesPage()));
                                                  }
                                                });
                                              });
                                            } else {
                                              _cartProvider.addItem(
                                                  _hvsUserProvider
                                                      .course16.courseIdName,
                                                  int.parse(_hvsUserProvider
                                                      .course16.coursePrice),
                                                  AppLocalizations.getString(
                                                      _hvsUserProvider.course16
                                                          .courseIdName),
                                                  "images/" +
                                                      _hvsUserProvider.course16
                                                          .courseIdName +
                                                      "_image.png");
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CartPage()));
                                            }
                                          },
                                          child: AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            opacity: opacity2,
                                            child: Container(
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    154, 206, 207, 1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          154, 206, 207, 1),
                                                      offset: const Offset(
                                                          1.1, 1.1),
                                                      blurRadius: 10.0),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _isCourse
                                                      ? AppLocalizations.getString(
                                                          "join_course_button_text")
                                                      : AppLocalizations.getString(
                                                          "get_course_button_text"),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    letterSpacing: 0.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void isGetCourse() async {
    _hvsUserProvider.getCourse16();
    await _hvsUserProvider.getUser();
    var realDateNow = await _dateAndNoteProvider.getRealTime();
    String dateNow = realDateNow.day.toString() +
        "." +
        realDateNow.month.toString() +
        "." +
        realDateNow.year.toString();
    if (_hvsUserProvider.getHvsUser.course.length > 0) {
      var courseList = _hvsUserProvider.getHvsUser.course
          .where((element) => element.courseId == "2")
          .toList();
      if (courseList.length > 0) {
        courseList.forEach((course) {
          course.dates.forEach((date) {
            if (date.date == dateNow) {
              _isCourse = true;
            }
          });
        });
      }
    }
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Color.fromRGBO(154, 206, 207, 1),
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
