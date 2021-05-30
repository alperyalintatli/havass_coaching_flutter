import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        //isCartIcon: false,
        isCoursePage: true,
      ),
      body: Container(),
    );
  }
}
