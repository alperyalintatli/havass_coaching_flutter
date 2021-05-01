import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/courses_page.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/cart_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';
import 'package:havass_coaching_flutter/widget/settings_drawer_widget.dart';
import 'package:provider/provider.dart';

class CourseInfoScreen21 extends StatefulWidget {
  @override
  _CourseInfoScreen21State createState() => _CourseInfoScreen21State();
}

class _CourseInfoScreen21State extends State<CourseInfoScreen21>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
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

  CartProvider _cartProvider;
  HvsUserProvider _hvsUserProvider;
  DateAndNoteProvider _dateAndNoteProvider;
  bool _isCourse = false;
  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    _dateAndNoteProvider = Provider.of<DateAndNoteProvider>(context);

    _hvsUserProvider.getUser();
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
                  child: Image.asset('images/course_28_photo.jpg'),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.4) - 24.0,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Text(
                              AppLocalizations.getString(
                                  "course_of_28_day_name"),
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
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '\$28.99',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: Color.fromRGBO(154, 206, 207, 1),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '4.8',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(154, 206, 207, 1),
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  getTimeBoxUI(
                                      '16', AppLocalizations.getString("days")),
                                  getTimeBoxUI('2hours', 'Time'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child: Text(
                                  'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () async {
                                      if (_isCourse) {
                                        await _hvsUserProvider.getUser();
                                        var dateList = _hvsUserProvider
                                            .getHvsUser
                                            .course
                                            .last
                                            .dates
                                            .first
                                            .date
                                            .split(".");
                                        _dateAndNoteProvider.getStartDate(
                                            DateTime(
                                                int.parse(
                                                    dateList[2].toString()),
                                                int.parse(
                                                    dateList[1].toString()),
                                                int.parse(
                                                    dateList[0].toString())));
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CoursesPage()));
                                      } else {
                                        _cartProvider.addItem(
                                            AppLocalizations.getString(
                                                "course_of_28_day_name"),
                                            300,
                                            AppLocalizations.getString(
                                                "course_of_28_day_name"),
                                            "images/course_28_photo.jpg");
                                      }
                                    },
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(154, 206, 207, 1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  154, 206, 207, 1),
                                              offset: const Offset(1.1, 1.1),
                                              blurRadius: 10.0),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          _isCourse
                                              ? 'Join Course'
                                              : 'Get Course',
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
                                  ))
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

  void isGetCourse() {
    String dateNow = DateTime.now().day.toString() +
        "." +
        DateTime.now().month.toString() +
        "." +
        DateTime.now().year.toString();
    if (_hvsUserProvider.getHvsUser.course.length > 0) {
      var courseList = _hvsUserProvider.getHvsUser.course
          .where((element) => element.courseId == "1")
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
