import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/pages/course_detail_page_16.dart';
import 'package:havass_coaching_flutter/pages/course_detail_page_28.dart';
import 'package:havass_coaching_flutter/plugins/firebase_firestore_services/firestore_operations.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/home_page/container_title_body_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/home_minshine_info_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/home_page_course_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'icon_list_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

FireStoreOperation store = FireStoreOperation.getInstance();

class _HomeWidgetState extends State<HomeWidget> {
  HvsUserProvider _hvsUserProvider;

  Widget userText() {
    return _hvsUserProvider == null
        ? CircularProgressIndicator()
        : Container(
            child: Center(
                child: Text(
              AppLocalizations.getString("welcome_title") +
                  ", " +
                  _hvsUserProvider.getHvsUser.name.toString(),
              style: TextStyle(fontSize: 18, color: Colors.white),
            )),
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.blueGrey.shade500);
  }

  @override
  void initState() {
    super.initState();
  }

  List<String> paragraph1 = [
    "home_first_paragraph_1",
    "home_first_paragraph_2",
    "home_first_paragraph_3",
    "home_first_paragraph_4",
    "home_first_paragraph_5",
    "home_first_paragraph_6",
    "home_first_paragraph_7"
  ];

  List<String> paragraph2 = [
    "home_second_paragraph_1",
    "home_second_paragraph_2",
    "home_second_paragraph_3",
    "home_second_paragraph_4",
    "home_second_paragraph_5",
    "home_second_paragraph_6",
    "home_second_paragraph_7",
    "home_second_paragraph_8"
  ];
  List<String> paragraph3 = ["home_third_paragraph_1"];
  List<IconList> iconList = [
    IconList(FontAwesomeIcons.medkit, "home_icon_1"),
    IconList(
      FontAwesomeIcons.solidHeart,
      "home_icon_2",
    ),
    IconList(FontAwesomeIcons.rocket, "home_icon_3"),
    IconList(FontAwesomeIcons.search, "home_icon_4"),
    IconList(FontAwesomeIcons.userShield, "home_icon_5"),
    IconList(FontAwesomeIcons.smileBeam, "home_icon_6")
  ];
  @override
  Widget build(BuildContext context) {
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            userText(),
            Image.asset("images/home/home_1_image.png"),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.getString("program_name"),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CourseButtonWidget(
                      courseName: "course_of_16",
                      imageName: "course_16_image.png",
                      dayofCourse: "16",
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var iconLike = prefs.getBool("Course_of_16_like");
                        _hvsUserProvider.getCourse16().then((value) =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CourseInfoScreen16(
                                      likeIcon: iconLike,
                                    ))));
                      },
                    ),
                    CourseButtonWidget(
                      courseName: "course_of_28",
                      imageName: "course_28_image.png",
                      dayofCourse: "28",
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var iconLike = prefs.getBool("Course_of_28_like");
                        _hvsUserProvider.getCourse28().then((value) =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CourseInfoScreen28(likeIcon: iconLike))));
                      },
                    ),
                  ]),
            ),
            ContainerTitleBodyWidget(
                title: "home_first_paragraph_title",
                body: paragraph1,
                backgroundColor: Color.fromARGB(255, 255, 132, 0)),
            ContainerTitleBodyWidget(
                title: "home_second_paragraph_title",
                body: paragraph2,
                backgroundColor: Color.fromARGB(255, 249, 166, 76)),
            ContainerTitleBodyWidget(
                title: "home_third_paragraph_title",
                body: paragraph3,
                backgroundColor: Color.fromARGB(255, 251, 193, 131)),
            IconListWidget(title: "home_icon_title", iconList: iconList),
            MindshineInfoWidget(
                title: "home_work_business_title",
                body: "home_work_business_body",
                imageName: "agenda.jpg"),
            MindshineInfoWidget(
                title: "power_of_affirmation_title",
                body: "power_of_affirmation_body",
                imageName: "affirmation.png"),
            MindshineInfoWidget(
                title: "telegram_title",
                body: "telegram_body",
                imageName: "community.png"),
            MindshineInfoWidget(
              title: "opinion_title",
              body: "opinion_body",
              imageName: "feedback.jpg",
              onTap: () {
                //buraya ios ve google play linki atılarak yıldız verilmesi sağlanacak
              },
            ),
          ],
        ),
      ),
    );
  }
}
