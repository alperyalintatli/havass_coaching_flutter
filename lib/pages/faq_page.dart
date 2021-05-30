import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        //isCartIcon: false,
        isCoursePage: true,
      ),
      body: FaqWidget(),
    );
  }
}

class FaqWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(children: [
          Align(alignment: Alignment.center, child: Text("FAQ")),
        ]),
      ),
    );
  }
}
