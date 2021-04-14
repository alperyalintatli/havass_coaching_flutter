import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/course_detail_page_16.dart';
import 'package:havass_coaching_flutter/pages/course_detail_page_21.dart';
import 'package:intl/intl.dart';

import '../Course_info_widget.dart';
import '../popup_calendar.dart';

class CourseWidget extends StatefulWidget {
  @override
  _CourseWidgetState createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CourseInfoScreen16())),
              child: Container(
                child: CourseInfoViewWidget(
                  courseName: "16 günlük kurs",
                  day: "16 günlük",
                  description: "açıklama",
                  imagePath: "images/person.png",
                  price: "150 €",
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CourseInfoScreen21())),
              child: CourseInfoViewWidget(
                  courseName: "21 günlük kurs",
                  day: "21 günlük",
                  description: "açıklama",
                  imagePath: "images/person.png",
                  price: "150 €"),
            ),
          ],
        ),
      ),
    );
  }
}
