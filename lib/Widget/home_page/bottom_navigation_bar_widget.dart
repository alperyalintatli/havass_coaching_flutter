import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/navigation_bottom_bar_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _setNavbarIndexProvider = Provider.of<NavBottombarProvider>(context);
    return Container(
      height: 80,
      child: BubbleBottomBar(
        opacity: .2,
        currentIndex: _setNavbarIndexProvider.index,
        onTap: _setNavbarIndexProvider.setIndex,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        hasNotch: false, //new
        hasInk: false, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(154, 206, 207, 1),
              icon: Icon(
                Icons.home,
                color: Colors.grey.shade600,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Color.fromRGBO(154, 206, 207, 1),
              ),
              title: Text(
                AppLocalizations.getString("home_text"),
                style: TextStyle(),
              )),
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(154, 206, 207, 1),
              icon: FaIcon(
                FontAwesomeIcons.atom,
                color: Colors.grey.shade600,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.atom,
                color: Color.fromRGBO(154, 206, 207, 1),
              ),
              title: Text(AppLocalizations.getString("quat_of_day_text"))),
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(154, 206, 207, 1),
              icon: FaIcon(
                FontAwesomeIcons.handPointer,
                color: Colors.grey.shade600,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.handPointer,
                color: Color.fromRGBO(154, 206, 207, 1),
              ),
              title: Text(AppLocalizations.getString("courses_text"))),
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(154, 206, 207, 1),
              icon: Icon(
                Icons.video_collection,
                color: Colors.grey.shade600,
              ),
              activeIcon: Icon(
                Icons.video_collection,
                color: Color.fromRGBO(154, 206, 207, 1),
              ),
              title: Text(AppLocalizations.getString("about_course_text")))
        ],
      ),
    );
  }
}
