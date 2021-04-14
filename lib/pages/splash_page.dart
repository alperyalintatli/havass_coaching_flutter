import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/pages/welcome_page.dart';
import 'package:havass_coaching_flutter/plugins/bloc/bloc_localization.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'home_page.dart';

class PageSplash extends StatefulWidget {
  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  LoginOperations _loginOperation;
  @override
  void initState() {
    _loginOperation = LoginOperations.getInstance();
    super.initState();
    initLanguage();
  }

  void initLanguage() async {
    final String language = await PrefUtils.getLanguage();
    BlocProvider.of<BlocLocalization>(context).add(
      language == "de" ? LocaleEvent.DE : LocaleEvent.EN,
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => SplashScreenView(
            home: _loginOperation.isLoggedIn() ? HomePage() : WelcomePage(),
            duration: _loginOperation.isLoggedIn() ? 3000 : 1000,
            imageSize: 300,
            imageSrc: "images/havass_logo.jpeg",
            backgroundColor: Colors.white,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(),
    );
  }
}
