import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  Widget topText() {
    return Container(
        child: Center(
            child: Text(
          "FAQ",
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
          children: [
            topText(),
            FaqWidget(),
          ],
        ),
      ),
    );
  }
}

class FaqWidget extends StatefulWidget {
  @override
  _FaqWidgetState createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  final List<String> _faqQuestion = [
    "faq_question_1",
    "faq_question_2",
    "faq_question_3",
    "faq_question_4",
    "faq_question_5",
    "faq_question_6",
    "faq_question_7",
    "faq_question_8",
    "faq_question_9"
  ];
  final List<String> _faqAnswer = [
    "faq_answer_1",
    "faq_answer_2",
    "faq_answer_3",
    "faq_answer_4",
    "faq_answer_5",
    "faq_answer_6",
    "faq_answer_7",
    "faq_answer_8",
    "faq_answer_9"
  ];
  List<int> faqIndex = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _faqQuestion.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: (faqIndex.any((element) => element == index))
                      ? Border.all(color: Colors.blueGrey.shade500)
                      : Border.all(color: Colors.white12),
                  color: Color.fromRGBO(164, 233, 232, 1)),
              child: Theme(
                data: ThemeData(
                    unselectedWidgetColor: Colors.white,
                    accentColor: Colors.blueGrey.shade500,
                    fontFamily: 'Montserrat'),
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    setState(() {
                      if (value == false) {
                        faqIndex.remove(index);
                      } else {
                        faqIndex.add(index);
                      }
                    });
                  },
                  title: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.questionCircle,
                          color: (faqIndex.any((element) => element == index))
                              ? Colors.blueGrey.shade500
                              : Colors.white),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            AppLocalizations.getString(_faqQuestion[index]),
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: (faqIndex
                                        .any((element) => element == index))
                                    ? Colors.blueGrey.shade500
                                    : Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        AppLocalizations.getString(_faqAnswer[index]),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
