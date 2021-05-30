import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/pages/course_detail_page_16.dart';
import 'package:havass_coaching_flutter/pages/course_detail_page_28.dart';
import 'package:provider/provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';

class CourseButtonWidget extends StatelessWidget {
  final String _buttonName;
  final String _courseName;
  CourseButtonWidget(this._buttonName, this._courseName);
  @override
  Widget build(BuildContext context) {
    HvsUserProvider _hvsUserProvider = Provider.of<HvsUserProvider>(context);

    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      width: MediaQuery.of(context).size.width / 1.5,
      height: 80,
      child: RaisedButton(
        elevation: 10,
        highlightColor: Color.fromRGBO(154, 206, 207, 1),
        color: Color.fromRGBO(154, 206, 207, 1), // background
        textColor: Colors.white, // foreground
        onPressed: () async {
          if (Constants.COURSE_OF_16 == _courseName) {
            _hvsUserProvider.getCourse16().then((value) => Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => CourseInfoScreen16())));
          } else if (Constants.COURSE_OF_28 == _courseName) {
            _hvsUserProvider.getCourse28().then((value) => Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => CourseInfoScreen28())));
          }
        },
        child: Text(
          _buttonName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
