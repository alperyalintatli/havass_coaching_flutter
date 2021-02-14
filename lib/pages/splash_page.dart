import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:havass_coaching_flutter/pages/welcome_page.dart';
import 'package:havass_coaching_flutter/plugins/bloc/bloc_localization.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';

class PageSplash extends StatefulWidget {
  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  @override
  void initState() {
    super.initState();
    initLanguage();
  }

  void initLanguage() async {
    final String language = await PrefUtils.getLanguage();
    BlocProvider.of<BlocLocalization>(context).add(
      language == "de" ? LocaleEvent.DE : LocaleEvent.EN,
    );
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => WelcomePage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(),
    );
  }
}
