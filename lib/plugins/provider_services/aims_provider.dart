import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';

class AimsProvider with ChangeNotifier {
  String _lang;
  get lang {
    return this._lang;
  }

  set lang(value) => this._lang = value;
  void getLang() async {
    _lang = await PrefUtils.getLanguage();
    notifyListeners();
  }
}
