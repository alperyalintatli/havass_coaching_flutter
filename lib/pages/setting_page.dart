import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/plugins/bloc/bloc_localization.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/aims_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/navigation_bottom_bar_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Widget topText() {
    return Container(
        child: Center(
            child: Text(
          AppLocalizations.getString("settings_title"),
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
        isSettingPage: true,
        isCoursePage: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            topText(),
            SettingWidget(),
          ],
        ),
      ),
    );
  }
}

class SettingWidget extends StatefulWidget {
  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  String _courseName = Constants.COURSE_OF_16;
  FocusNode focusNode = new FocusNode();
  LoginOperations _loginOperation = LoginOperations.getInstance();
  HvsUserProvider _userProvider;
  AimsProvider _aimsProvider;
  NavBottombarProvider _navBottombarProvider;
  final _passwordChangeFormKey = GlobalKey<FormState>();
  final _userNameChangeFormKey = GlobalKey<FormState>();
  final _manuelStudentAddFormKey = GlobalKey<FormState>();

  String _newPassword;
  String _oldPassword;
  String _userName;
  String _email;
  Widget _entryField(String title,
      {bool isNewPassword = false,
      bool isOldPassword = false,
      bool isUserName = false,
      bool isEmail = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              focusNode: isUserName ? focusNode : null,
              onSaved: (value) {
                if (isNewPassword) {
                  _newPassword = value;
                } else if (isOldPassword) {
                  _oldPassword = value;
                } else if (isUserName) {
                  _userName = value;
                } else if (isEmail) {
                  _email = value;
                }
              },
              validator: (value) {
                if (value.isEmpty) {
                  return '*' +
                      AppLocalizations.getString(
                          "register_page_validation_empty_field");
                }
                if (isNewPassword || isOldPassword) {
                  if (value.length < 6) {
                    return '*' +
                        AppLocalizations.getString(
                            "register_page_validation_password_field");
                  }
                }
                if (isEmail) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);

                  if (!emailValid) {
                    return '*' +
                        AppLocalizations.getString(
                            "register_page_validation_email_field");
                  }
                }
                return null;
              },
              cursorColor: Colors.blueGrey.shade500,
              obscureText: isNewPassword || isOldPassword,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade500),
                ),
                labelStyle: TextStyle(
                    color: focusNode.hasFocus
                        ? Colors.blueGrey.shade500
                        : Colors.blueGrey.shade500),
                labelText: isUserName == true
                    ? (_userProvider.getHvsUser.name ?? null)
                    : null,
                hintText: title,
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                fillColor: Color.fromRGBO(164, 233, 232, 1),
                filled: true,
              )),
        ],
      ),
    );
  }

  List<int> faqIndex = [];
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<HvsUserProvider>(context);
    _aimsProvider = Provider.of<AimsProvider>(context);
    _navBottombarProvider =
        Provider.of<NavBottombarProvider>(context, listen: false);
    _userProvider.checkRole();
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: Colors.blueGrey.shade500,
          accentColor: Colors.blueGrey.shade500,
          fontFamily: 'Montserrat'),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueGrey.shade500),
                color: Color.fromRGBO(164, 233, 232, 1)),
            child: ExpansionTile(
              title: Text(
                AppLocalizations.getString("userName_title"),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade500),
              ),
              children: [
                Form(
                  key: _userNameChangeFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _entryField(
                          AppLocalizations.getString("new_userName_title"),
                          isUserName: true),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.save,
                          color: Colors.blueGrey.shade500,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_userNameChangeFormKey.currentState
                                .validate()) {
                              _userNameChangeFormKey.currentState.save();
                              _changeUserName(_userName);
                            }
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueGrey.shade500),
                color: Color.fromRGBO(164, 233, 232, 1)),
            child: ExpansionTile(
              title: Text(
                AppLocalizations.getString("change_password_title"),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade500),
              ),
              children: [
                Form(
                  key: _passwordChangeFormKey,
                  child: Column(
                    children: [
                      _entryField(
                          AppLocalizations.getString("current_password_title"),
                          isOldPassword: true),
                      _entryField(
                          AppLocalizations.getString("new_password_title"),
                          isNewPassword: true),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: IconButton(
                        icon: Icon(Icons.save, color: Colors.blueGrey.shade500),
                        onPressed: () {
                          setState(() {
                            if (_passwordChangeFormKey.currentState
                                .validate()) {
                              _passwordChangeFormKey.currentState.save();
                              _changePassword(
                                  newPassword: _newPassword,
                                  oldPassword: _oldPassword);
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueGrey.shade500),
                color: Color.fromRGBO(164, 233, 232, 1)),
            child: ExpansionTile(
              title: Text(
                AppLocalizations.getString("language_title"),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade500),
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('images/english-flag-icon.png'),
                      onPressed: () async {
                        FirebaseMessaging _f = FirebaseMessaging();
                        await _f.subscribeToTopic("en");
                        await _f.unsubscribeFromTopic("de");
                        setState(() {
                          BlocProvider.of<BlocLocalization>(context)
                              .add(LocaleEvent.EN);
                          Future.delayed(Duration(seconds: 1),
                              () => _aimsProvider.getLang());
                        });
                      },
                    ),
                    IconButton(
                        icon: Image.asset('images/german-flag-icon.png'),
                        onPressed: () async {
                          FirebaseMessaging _f = FirebaseMessaging();
                          await _f.subscribeToTopic("de");
                          await _f.unsubscribeFromTopic("en");
                          setState(() {
                            BlocProvider.of<BlocLocalization>(context)
                                .add(LocaleEvent.DE);
                            Future.delayed(Duration(seconds: 4),
                                () => _aimsProvider.getLang());
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
          _userProvider.getIsAdmin
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueGrey.shade500),
                      color: Color.fromRGBO(164, 233, 232, 1)),
                  child: ExpansionTile(
                    title: Text(
                      AppLocalizations.getString("manuel_add_student_text"),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade500),
                    ),
                    children: [
                      Form(
                        key: _manuelStudentAddFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _entryField(
                              "E-Mail",
                              isEmail: true,
                            ),
                          ],
                        ),
                      ),
                      DropdownButton(
                          value: _courseName,
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                  AppLocalizations.getString("course_of_16")),
                              value: Constants.COURSE_OF_16,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                  AppLocalizations.getString("course_of_28")),
                              value: Constants.COURSE_OF_28,
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _courseName = value;
                            });
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                try {
                                  setState(() {
                                    if (_manuelStudentAddFormKey.currentState
                                        .validate()) {
                                      _manuelStudentAddFormKey.currentState
                                          .save();
                                      _addManuelStudent(_email, _courseName);
                                    }
                                  });
                                } catch (e) {}
                              }),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _changeUserName(String userName) async {
    bool _isChangeUserName = await _userProvider.changeUserName(userName);
    if (_isChangeUserName) {
      NotificationWidget.showNotification(
          context,
          AppLocalizations.getString(
              "userName_change_notification_success_title"));
    } else {
      NotificationWidget.showNotification(
          context,
          AppLocalizations.getString(
              "userName_change_notification_error_title"));
    }
  }

  void _addManuelStudent(String email, String courseName) async {
    try {
      bool _isChangeUserName =
          await _userProvider.addManuelStudent(email, courseName);
      if (_isChangeUserName) {
        NotificationWidget.showNotification(
            context, AppLocalizations.getString("manuel_course_add_success"));
      } else {
        NotificationWidget.showNotification(
            context, AppLocalizations.getString("manuel_course_add_error"));
      }
    } catch (e) {}
  }

  void _changePassword({String oldPassword, String newPassword}) async {
    var result = await _loginOperation.changePassword(oldPassword, newPassword);
    if (result != null) {
      if (result.isChangePasswordSuccess) {
        NotificationWidget.showNotification(
            context,
            AppLocalizations.getString(
                "password_change_notification_success_title"));
      } else if (result.isValidatePassword) {
        NotificationWidget.showNotification(
            context,
            AppLocalizations.getString(
                "password_change_notification_old_password_title"));
      } else if (result.isError) {
        NotificationWidget.showNotification(
            context,
            AppLocalizations.getString(
                "password_change_notification_error_title"));
      }
    } else {
      NotificationWidget.showNotification(
          context,
          AppLocalizations.getString(
              "password_change_notification_error_title"));
    }
  }
}

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
