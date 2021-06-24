import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  Widget topText() {
    return Container(
        child: Center(
            child: Text(
          AppLocalizations.getString("privacy_policy"),
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        )),
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: Colors.blueGrey.shade500);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        isCartIcon: false,
        isCoursePage: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [topText(), PrivacyPolicyWidget()],
      )),
    );
  }
}

class PrivacyPolicyWidget extends StatefulWidget {
  @override
  _PrivacyPolicyWidgetState createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  final List<String> _privacyPolicyTitle = [
    "",
    "privacy_policy_title_1",
    "privacy_policy_title_2",
    "privacy_policy_title_3",
    "privacy_policy_title_4",
    "privacy_policy_title_5",
    "privacy_policy_title_6"
  ];
  final List<String> _privacyPolicyBody = [
    "privacy_policy_body_1",
    "privacy_policy_body_2",
    "privacy_policy_body_3",
    "privacy_policy_body_4",
    "privacy_policy_body_5",
    "privacy_policy_body_6",
    "privacy_policy_body_7"
  ];
  List<int> faqIndex = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _privacyPolicyBody.length,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     border: (faqIndex.any((element) => element == index))
                //         ? Border.all(color: Colors.blueGrey.shade500)
                //         : Border.all(color: Colors.white12),
                //     color: Color.fromRGBO(164, 233, 232, 1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (_privacyPolicyTitle[index] != "")
                        ? Text(
                            AppLocalizations.getString(
                                _privacyPolicyTitle[index]),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade500),
                          )
                        : Container(),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      //"\t\t" +
                      AppLocalizations.getString(_privacyPolicyBody[index]),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14, color: Colors.blueGrey.shade500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ));
          }),
    );
  }
}
