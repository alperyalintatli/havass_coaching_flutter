import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';

class CourseButtonWidget extends StatefulWidget {
  final String courseName;
  final String imageName;
  final String dayofCourse;
  final VoidCallback onTap;
  CourseButtonWidget(
      {@required this.courseName,
      @required this.imageName,
      @required this.dayofCourse,
      this.onTap});

  @override
  _CourseButtonWidgetState createState() => _CourseButtonWidgetState();
}

class _CourseButtonWidgetState extends State<CourseButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.width * 0.3,
              child: Image.asset(
                "images/home/${widget.imageName}",
              )),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: Text(AppLocalizations.getString(widget.courseName),
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
                "(${widget.dayofCourse} " +
                    AppLocalizations.getString("day") +
                    ")",
                style: TextStyle(
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }
}
