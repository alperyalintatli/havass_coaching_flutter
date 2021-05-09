import 'dart:async';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/plugins/firebase_firestore_services/firestore_operations.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/firestore_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/home_page/about_me_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/aims_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/home_page_course_button_widget.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

FireStoreOperation store = FireStoreOperation.getInstance();

class _HomeWidgetState extends State<HomeWidget> {
  HvsUserProvider _hvsUserProvider;
  FirestoreProvider _fireStoreProvider;

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

  List<Widget> _listHomeSlider() {
    _fireStoreProvider.homeSliderWidgetList(context);
    return _fireStoreProvider.homeSliderList;
  }

  Widget _homeSlider;
  Timer _timerOfSlider;
  void _getListSlider() {
    _timerOfSlider = Timer(Duration(seconds: Random().nextInt(3)), () {
      _homeSlider = Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        child: CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              height: MediaQuery.of(context).size.height / 2),
          items: _listHomeSlider(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _fireStoreProvider = Provider.of<FirestoreProvider>(context);
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);

    _getListSlider();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            userText(),
            _homeSlider == null
                ? Container(
                    margin: EdgeInsets.only(top: 125, bottom: 125),
                    child: CircularProgressIndicator(),
                  )
                : _homeSlider,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CourseButtonWidget(
                    AppLocalizations.getString(Constants.COURSE_OF_16),
                    Constants.COURSE_OF_16),
              ],
            ),
            AimsListWidget16(),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CourseButtonWidget(
                    AppLocalizations.getString(Constants.COURSE_OF_28),
                    Constants.COURSE_OF_28),
              ],
            ),
            AimsListWidget28(),
            AboutMeWidget(
              AppLocalizations.getString("audio_info"),
              isDisplay: false,
            ),
            AboutMeWidget(
                AppLocalizations.getString("main_menu_about_app_description")),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timerOfSlider.cancel();
    super.dispose();
  }
}
