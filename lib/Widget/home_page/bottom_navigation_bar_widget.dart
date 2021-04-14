import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/navigation_bottom_bar_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
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
        fabLocation: BubbleBottomBarFabLocation.end,
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
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
                "Home",
                style: TextStyle(),
              )),
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(154, 206, 207, 1),
              icon: Icon(
                Icons.eco_sharp,
                color: Colors.grey.shade600,
              ),
              activeIcon: Icon(
                Icons.eco_sharp,
                color: Color.fromRGBO(154, 206, 207, 1),
              ),
              title: Text("Quat of Day")),
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(154, 206, 207, 1),
              icon: Icon(
                Icons.golf_course,
                color: Colors.grey.shade600,
              ),
              activeIcon: Icon(
                Icons.golf_course,
                color: Color.fromRGBO(154, 206, 207, 1),
              ),
              title: Text("Courses")),
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
              title: Text("About Course"))
        ],
      ),
    );
  }
}
