import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/navigation_bottom_bar_provider.dart';
import 'package:havass_coaching_flutter/widget/home_page/bottom_navigation_bar_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/course_menu_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/main_menu_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => NavBottombarProvider(0), child: MainPageDesign());
  }
}

class MainPageDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _setNavbarIndexProvider = Provider.of<NavBottombarProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Havass"),
                Text(
                  "App",
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: null,
              iconSize: 32,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
        return CourseWidget();
        break;
      default:
        return HomeWidget();
    }
  }
}
