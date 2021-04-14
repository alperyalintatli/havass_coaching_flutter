import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/courses.dart';
import 'package:havass_coaching_flutter/pages/courses_page.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/navigation_bottom_bar_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/bottom_navigation_bar_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/course_menu_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/main_menu_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/quat_of_day_menu_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/video_widget.dart';
import 'package:havass_coaching_flutter/widget/settings_drawer_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MainPageDesign();
  }
}

class MainPageDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HvsUserProvider _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    DateAndNoteProvider _dateAndNoteProvider =
        Provider.of<DateAndNoteProvider>(context);
    var _setNavbarIndexProvider = Provider.of<NavBottombarProvider>(context);
    return Scaffold(
      endDrawer: SettingsDrawerWidget(),
      appBar: AppBarWidget(
        isPopup: false,
      ),
      floatingActionButton: _setNavbarIndexProvider.index == 2
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await _hvsUserProvider.getUser();
                var dateList = _hvsUserProvider
                    .getHvsUser.course.last.dates.first.date
                    .split(".");
                _dateAndNoteProvider.getStartDate(DateTime(
                    int.parse(dateList[2].toString()),
                    int.parse(dateList[1].toString()),
                    int.parse(dateList[0].toString())));
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CoursesPage()));
              },
              child: Icon(Icons.add),
              backgroundColor: Color.fromRGBO(164, 233, 232, 1),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: setWidget(_setNavbarIndexProvider.index),
    );
  }

  Widget setWidget(int index) {
    switch (index) {
      case 0:
        return HomeWidget();
        break;
      case 1:
        return QuateOfDayWidget();
        break;
      case 2:
        return CourseWidget();
        break;
      case 3:
        return VideoWidget();
        break;
      default:
        return HomeWidget();
        break;
    }
  }
}
