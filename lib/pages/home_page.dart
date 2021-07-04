import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/cart_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/navigation_bottom_bar_provider.dart';

import 'package:havass_coaching_flutter/widget/appBar_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/bottom_navigation_bar_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/course_menu_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/main_menu_widget.dart';
import 'package:havass_coaching_flutter/widget/home_page/quat_of_day_menu_widget.dart';
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
    var _setNavbarIndexProvider = Provider.of<NavBottombarProvider>(context);
    CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return _cartProvider.getIsPayment == false
        ? Scaffold(
            endDrawer: SettingsDrawerWidget(),
            appBar: AppBarWidget(
              isPopup: false,
            ),
            // floatingActionButton: _setNavbarIndexProvider.index == 2
            //     ? null
            //     : FloatingActionButton(
            //         onPressed: () async {
            //           await _hvsUserProvider.getUser();
            //           var dateList = _hvsUserProvider
            //               .getHvsUser.course.last.dates.first.date
            //               .split(".");
            //           _dateAndNoteProvider.getStartDate(DateTime(
            //               int.parse(dateList[2].toString()),
            //               int.parse(dateList[1].toString()),
            //               int.parse(dateList[0].toString())));
            //           Navigator.of(context).push(MaterialPageRoute(
            //               builder: (context) => CoursesPage()));
            //         },
            //         child: Icon(Icons.add),
            //         backgroundColor: Color.fromRGBO(164, 233, 232, 1),
            //       ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BottomNavigationBarWidget(),
            body: setWidget(_setNavbarIndexProvider.index),
          )
        : AbsorbPointer(
            absorbing: true,
            child: Scaffold(
                endDrawer: SettingsDrawerWidget(),
                appBar: AppBarWidget(
                  isPopup: false,
                ),
                // floatingActionButton: _setNavbarIndexProvider.index == 2
                //     ? null
                //     : FloatingActionButton(
                //         onPressed: () async {
                //           await _hvsUserProvider.getUser();
                //           var dateList = _hvsUserProvider
                //               .getHvsUser.course.last.dates.first.date
                //               .split(".");
                //           _dateAndNoteProvider.getStartDate(DateTime(
                //               int.parse(dateList[2].toString()),
                //               int.parse(dateList[1].toString()),
                //               int.parse(dateList[0].toString())));
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => CoursesPage()));
                //         },
                //         child: Icon(Icons.add),
                //         backgroundColor: Color.fromRGBO(164, 233, 232, 1),
                //       ),
                // floatingActionButtonLocation:
                //     FloatingActionButtonLocation.endDocked,
                bottomNavigationBar: BottomNavigationBarWidget(),
                body: _cartProvider.getIsPayment == false
                    ? setWidget(_setNavbarIndexProvider.index)
                    : Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 320,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromRGBO(122, 205, 223, 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Color.fromRGBO(122, 205, 223, 1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.getString(
                                          "payment_made_progress_indicator"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Container(
                                        width: 280,
                                        height: 280,
                                        child: Image.asset("images/giphy.gif"))
                                    // CircularProgressIndicator(
                                    //   valueColor: AlwaysStoppedAnimation<
                                    //           Color>(
                                    //       Color.fromRGBO(153, 201, 189, 1)),
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // ListTile(
                          //   leading: Text("aaa"),
                          //   dense: true,
                          //   subtitle: Text("basd"),
                          //   title: Text("ccc"),
                          // ),
                          //color: Color.fromRGBO(116, 198, 226, 1),
                        ),
                      )),
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
      // case 3:
      //   return VideoWidget();
      //   break;
      default:
        return HomeWidget();
        break;
    }
  }
}
