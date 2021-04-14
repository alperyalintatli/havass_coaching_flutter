import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:havass_coaching_flutter/plugins/bloc/bloc_localization.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'home_page.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage(this._page);
  final Widget _page;
  @override
  _LoadingPageState createState() => _LoadingPageState(_page);
}

class _LoadingPageState extends State<LoadingPage> {
  final Widget _page;
  _LoadingPageState(this._page);
  @override
  void initState() {
    super.initState();
    initLoading(_page);
  }

  void initLoading(Widget page) async {
    final String language = await PrefUtils.getLanguage();
    BlocProvider.of<BlocLocalization>(context).add(
      language == "de" ? LocaleEvent.DE : LocaleEvent.EN,
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => SplashScreenView(
        home: page ?? HomePage(),
        duration: 1000,
        imageSize: 300,
        imageSrc: "images/havass_logo.jpeg",
        backgroundColor: Colors.white,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(),
    );
  }
}
