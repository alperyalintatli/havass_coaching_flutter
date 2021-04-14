import 'package:flutter/material.dart';

class CourseButtonWidget extends StatelessWidget {
  final String _buttonName;
  CourseButtonWidget(this._buttonName);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      width: MediaQuery.of(context).size.width / 3,
      height: 80,
      child: RaisedButton(
        elevation: 10,
        highlightColor: Color.fromRGBO(154, 206, 207, 1),
        color: Color.fromRGBO(154, 206, 207, 1), // background
        textColor: Colors.white, // foreground
        onPressed: () {},
        child: Text(_buttonName),
      ),
    );
  }
}
