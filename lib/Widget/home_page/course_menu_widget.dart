import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/course_detail_page_16.dart';
import 'package:havass_coaching_flutter/pages/course_detail_page_28.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Course_info_widget.dart';

class CourseWidget extends StatefulWidget {
  @override
  _CourseWidgetState createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget>
    with TickerProviderStateMixin {
  AnimationController animationController;
  HvsUserProvider _hvsUserProvider;

  @override
  Widget build(BuildContext context) {
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    _hvsUserProvider.getCourse16();
    _hvsUserProvider.getCourse28();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    return Container(
      child: (_hvsUserProvider.course16.courseIdName == null ||
              _hvsUserProvider.course28.courseIdName == null)
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(153, 201, 189, 1))),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var iconLike = prefs.getBool("Course_of_16_like");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CourseInfoScreen16(
                                likeIcon: iconLike,
                              )));
                    },
                    child: Container(
                      child: CourseInfoViewWidget(
                        courseName: AppLocalizations.getString(
                            _hvsUserProvider.course16.courseIdName),
                        day:
                            "${_hvsUserProvider.course16.courseDay} ${AppLocalizations.getString("days")}",
                        imagePath:
                            "images/${_hvsUserProvider.course16.courseIdName}_image.png",
                        price: "",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var iconLike = prefs.getBool("Course_of_28_like");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CourseInfoScreen28(
                                likeIcon: iconLike,
                              )));
                    },
                    child: CourseInfoViewWidget(
                      courseName: AppLocalizations.getString(
                          _hvsUserProvider.course28.courseIdName),
                      day:
                          "${_hvsUserProvider.course28.courseDay} ${AppLocalizations.getString("days")}",
                      imagePath:
                          "images/${_hvsUserProvider.course28.courseIdName}_image.png",
                      price: "",
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
