import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/pages/faq_page.dart';
import 'package:havass_coaching_flutter/pages/past_courses_list_page.dart';
import 'package:havass_coaching_flutter/pages/privacy_policy_page.dart';
import 'package:havass_coaching_flutter/pages/setting_page.dart';
import 'package:havass_coaching_flutter/pages/welcome_page.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/navigation_bottom_bar_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:provider/provider.dart';

class SettingsDrawerWidget extends StatefulWidget {
  @override
  _SettingsDrawerWidgetState createState() => _SettingsDrawerWidgetState();
}

class _SettingsDrawerWidgetState extends State<SettingsDrawerWidget> {
  LoginOperations _loginOperation = LoginOperations.getInstance();
  HvsUserProvider _userProvider;
  // AimsProvider _aimsProvider;
  NavBottombarProvider _navBottombarProvider;

  // final _passwordChangeFormKey = GlobalKey<FormState>();
  // final _userNameChangeFormKey = GlobalKey<FormState>();
  // final _manuelStudentAddFormKey = GlobalKey<FormState>();

  // String _newPassword;
  // String _oldPassword;
  // String _userName;
  // String _email;
  // Widget _entryField(String title,
  //     {bool isNewPassword = false,
  //     bool isOldPassword = false,
  //     bool isUserName = false,
  //     bool isEmail = false}) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         TextFormField(
  //             onSaved: (value) {
  //               if (isNewPassword) {
  //                 _newPassword = value;
  //               } else if (isOldPassword) {
  //                 _oldPassword = value;
  //               } else if (isUserName) {
  //                 _userName = value;
  //               } else if (isEmail) {
  //                 _email = value;
  //               }
  //             },
  //             validator: (value) {
  //               if (value.isEmpty) {
  //                 return '*' +
  //                     AppLocalizations.getString(
  //                         "register_page_validation_empty_field");
  //               }
  //               if (isNewPassword || isOldPassword) {
  //                 if (value.length < 6) {
  //                   return '*' +
  //                       AppLocalizations.getString(
  //                           "register_page_validation_password_field");
  //                 }
  //               }
  //               if (isEmail) {
  //                 bool emailValid = RegExp(
  //                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //                     .hasMatch(value);

  //                 if (!emailValid) {
  //                   return '*' +
  //                       AppLocalizations.getString(
  //                           "register_page_validation_email_field");
  //                 }
  //               }
  //               return null;
  //             },
  //             cursorColor: Colors.blue,
  //             obscureText: isNewPassword || isOldPassword,
  //             decoration: InputDecoration(
  //               labelText: isUserName == true
  //                   ? (_userProvider.getHvsUser.name ?? null)
  //                   : null,
  //               hintText: title,
  //               border: UnderlineInputBorder(
  //                   borderRadius: BorderRadius.circular(5.0)),
  //               fillColor: Color.fromRGBO(164, 233, 232, 1),
  //               filled: true,
  //             )),
  //       ],
  //     ),
  //   );
  // }

  // String _courseName = Constants.COURSE_OF_16;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<HvsUserProvider>(context);
    // _aimsProvider = Provider.of<AimsProvider>(context);
    _navBottombarProvider =
        Provider.of<NavBottombarProvider>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    _userProvider.checkRole();
    return Theme(
      data:
          Theme.of(context).copyWith(canvasColor: Color.fromRGBO(0, 0, 0, 0.5)),
      child: Drawer(
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                height: height * .15,
                child: DrawerHeader(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_userProvider.getHvsUser.name,
                          // AppLocalizations.getString("settings_title"),
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      // Image.asset(
                      //   'images/havass_logo_1.png',
                      //   height: 50,
                      //   width: 50,
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                height: height * .85,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        // Theme(
                        //   data: ThemeData(
                        //       fontFamily: 'Montserrat',
                        //       accentColor: Colors.white,
                        //       cursorColor: Colors.white),
                        //   child: ExpansionTile(
                        //     title: Text(
                        //       AppLocalizations.getString("userName_title"),
                        //       style: TextStyle(
                        //           fontSize: 16.0, fontWeight: FontWeight.bold),
                        //     ),
                        //     children: [
                        //       Form(
                        //         key: _userNameChangeFormKey,
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             _entryField(
                        //                 AppLocalizations.getString(
                        //                     "new_userName_title"),
                        //                 isUserName: true),
                        //           ],
                        //         ),
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           IconButton(
                        //               icon: Icon(
                        //                 Icons.save,
                        //                 color: Colors.white,
                        //               ),
                        //               onPressed: () {
                        //                 setState(() {
                        //                   if (_userNameChangeFormKey
                        //                       .currentState
                        //                       .validate()) {
                        //                     _userNameChangeFormKey.currentState
                        //                         .save();
                        //                     _changeUserName(_userName);
                        //                   }
                        //                 });
                        //               }),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Theme(
                        //   data: ThemeData(
                        //       accentColor: Colors.white,
                        //       fontFamily: 'Montserrat'),
                        //   child: ExpansionTile(
                        //     title: Text(
                        //       AppLocalizations.getString(
                        //           "change_password_title"),
                        //       style: TextStyle(
                        //           fontSize: 16.0, fontWeight: FontWeight.bold),
                        //     ),
                        //     children: [
                        //       Form(
                        //         key: _passwordChangeFormKey,
                        //         child: Column(
                        //           children: [
                        //             _entryField(
                        //                 AppLocalizations.getString(
                        //                     "current_password_title"),
                        //                 isOldPassword: true),
                        //             _entryField(
                        //                 AppLocalizations.getString(
                        //                     "new_password_title"),
                        //                 isNewPassword: true),
                        //           ],
                        //         ),
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Container(
                        //             margin: EdgeInsets.only(bottom: 5),
                        //             child: IconButton(
                        //               icon:
                        //                   Icon(Icons.save, color: Colors.white),
                        //               onPressed: () {
                        //                 setState(() {
                        //                   if (_passwordChangeFormKey
                        //                       .currentState
                        //                       .validate()) {
                        //                     _passwordChangeFormKey.currentState
                        //                         .save();
                        //                     _changePassword(
                        //                         newPassword: _newPassword,
                        //                         oldPassword: _oldPassword);
                        //                   }
                        //                 });
                        //               },
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Theme(
                        //   data: ThemeData(
                        //       accentColor: Colors.white,
                        //       fontFamily: 'Montserrat'),
                        //   child: ExpansionTile(
                        //     title: Text(
                        //       AppLocalizations.getString("language_title"),
                        //       style: TextStyle(
                        //           fontSize: 16.0, fontWeight: FontWeight.bold),
                        //     ),
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           IconButton(
                        //             icon: Image.asset(
                        //                 'images/english-flag-icon.png'),
                        //             onPressed: () async {
                        //               FirebaseMessaging _f =
                        //                   FirebaseMessaging();
                        //               await _f.subscribeToTopic("en");
                        //               await _f.unsubscribeFromTopic("de");
                        //               setState(() {
                        //                 BlocProvider.of<BlocLocalization>(
                        //                         context)
                        //                     .add(LocaleEvent.EN);
                        //                 Future.delayed(Duration(seconds: 1),
                        //                     () => _aimsProvider.getLang());
                        //               });
                        //             },
                        //           ),
                        //           IconButton(
                        //               icon: Image.asset(
                        //                   'images/german-flag-icon.png'),
                        //               onPressed: () async {
                        //                 FirebaseMessaging _f =
                        //                     FirebaseMessaging();
                        //                 await _f.subscribeToTopic("de");
                        //                 await _f.unsubscribeFromTopic("en");
                        //                 setState(() {
                        //                   BlocProvider.of<BlocLocalization>(
                        //                           context)
                        //                       .add(LocaleEvent.DE);
                        //                   Future.delayed(Duration(seconds: 4),
                        //                       () => _aimsProvider.getLang());
                        //                 });
                        //               }),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // _userProvider.getIsAdmin
                        //     ? Theme(
                        //         data: ThemeData(
                        //             accentColor: Colors.white,
                        //             fontFamily: 'Montserrat'),
                        //         child: ExpansionTile(
                        //           title: Text(
                        //             AppLocalizations.getString(
                        //                 "manuel_add_student_text"),
                        //             style: TextStyle(
                        //               fontSize: 16.0,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //           children: [
                        //             Form(
                        //               key: _manuelStudentAddFormKey,
                        //               child: Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   _entryField(
                        //                     "E-Mail",
                        //                     isEmail: true,
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //             DropdownButton(
                        //                 value: _courseName,
                        //                 items: [
                        //                   DropdownMenuItem(
                        //                     child: Text(
                        //                         AppLocalizations.getString(
                        //                             "course_of_16")),
                        //                     value: Constants.COURSE_OF_16,
                        //                   ),
                        //                   DropdownMenuItem(
                        //                     child: Text(
                        //                         AppLocalizations.getString(
                        //                             "course_of_28")),
                        //                     value: Constants.COURSE_OF_28,
                        //                   )
                        //                 ],
                        //                 onChanged: (value) {
                        //                   setState(() {
                        //                     _courseName = value;
                        //                   });
                        //                 }),
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 IconButton(
                        //                     icon: Icon(
                        //                       Icons.save,
                        //                       color: Colors.white,
                        //                     ),
                        //                     onPressed: () {
                        //                       try {
                        //                         setState(() {
                        //                           if (_manuelStudentAddFormKey
                        //                               .currentState
                        //                               .validate()) {
                        //                             _manuelStudentAddFormKey
                        //                                 .currentState
                        //                                 .save();
                        //                             _addManuelStudent(
                        //                                 _email, _courseName);
                        //                           }
                        //                         });
                        //                       } catch (e) {}
                        //                     }),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     : Container(),
                        SizedBox(
                          height: 40,
                        ),
                        _navBottombarProvider.index != 2
                            ? Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.doorOpen,
                                        color: Colors.white),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextButton(
                                          child: Text(
                                            AppLocalizations.getString(
                                                "old_courses_title"),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PastCoursesListPage()));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.cogs,
                                  color: Colors.white),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SettingPage()));
                                      },
                                      child: Text(
                                        AppLocalizations.getString(
                                            "settings_title"),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.newspaper,
                                  color: Colors.white),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PrivacyPolicyPage()));
                                      },
                                      child: Text(
                                        AppLocalizations.getString(
                                            "privacy_policy_title"),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.questionCircle,
                                  color: Colors.white),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FaqPage()));
                                      },
                                      child: Text(
                                        AppLocalizations.getString("faq_title"),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RawMaterialButton(
                          onPressed: () async {
                            await _loginOperation.signOut().whenComplete(() =>
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => WelcomePage()),
                                    (Route<dynamic> route) => false));
                          },
                          elevation: 5.0,
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.logout,
                            size: 20.0,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void _changeUserName(String userName) async {
  //   bool _isChangeUserName = await _userProvider.changeUserName(userName);
  //   if (_isChangeUserName) {
  //     NotificationWidget.showNotification(
  //         context,
  //         AppLocalizations.getString(
  //             "userName_change_notification_success_title"));
  //   } else {
  //     NotificationWidget.showNotification(
  //         context,
  //         AppLocalizations.getString(
  //             "userName_change_notification_error_title"));
  //   }
  // }

  // void _addManuelStudent(String email, String courseName) async {
  //   try {
  //     bool _isChangeUserName =
  //         await _userProvider.addManuelStudent(email, courseName);
  //     if (_isChangeUserName) {
  //       NotificationWidget.showNotification(
  //           context, AppLocalizations.getString("manuel_course_add_success"));
  //     } else {
  //       NotificationWidget.showNotification(
  //           context, AppLocalizations.getString("manuel_course_add_error"));
  //     }
  //   } catch (e) {}
  // }

  // void _changePassword({String oldPassword, String newPassword}) async {
  //   var result = await _loginOperation.changePassword(oldPassword, newPassword);
  //   if (result != null) {
  //     if (result.isChangePasswordSuccess) {
  //       NotificationWidget.showNotification(
  //           context,
  //           AppLocalizations.getString(
  //               "password_change_notification_success_title"));
  //     } else if (result.isValidatePassword) {
  //       NotificationWidget.showNotification(
  //           context,
  //           AppLocalizations.getString(
  //               "password_change_notification_old_password_title"));
  //     } else if (result.isError) {
  //       NotificationWidget.showNotification(
  //           context,
  //           AppLocalizations.getString(
  //               "password_change_notification_error_title"));
  //     }
  //   } else {
  //     NotificationWidget.showNotification(
  //         context,
  //         AppLocalizations.getString(
  //             "password_change_notification_error_title"));
  //   }
  // }
}
