import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static const String PREFS_LANGUAGE = "lang";
  static const String PREFS_QUATOFDAY = "quatOfDay";
  static const String PREFS_NUMBEROFMANDALA = "numberOfMandala";
  static const String PREFS_NUMBEROFQUAT = "numberOfQuat";
  static const String PREFS_ISSCRACTHQUAT = "isScratchQuat";

  static void saveLanguage(Locale locale) {
    SharedPreferences.getInstance().then((prefs) {
      String curLang = prefs.getString(PREFS_LANGUAGE) ?? "";
      if (curLang != locale.languageCode)
        prefs.setString(PREFS_LANGUAGE, locale.languageCode);
    });
  }

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREFS_LANGUAGE) ?? "en";
  }

  static void saveQuatOfDayNumbers(Map<String, dynamic> quatOfDayNumbers) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(PREFS_QUATOFDAY, quatOfDayNumbers[PREFS_QUATOFDAY]);
      prefs.setString(
          PREFS_NUMBEROFMANDALA, quatOfDayNumbers[PREFS_NUMBEROFMANDALA]);
      prefs.setString(PREFS_NUMBEROFQUAT, quatOfDayNumbers[PREFS_NUMBEROFQUAT]);
      prefs.setBool(PREFS_ISSCRACTHQUAT, quatOfDayNumbers[PREFS_ISSCRACTHQUAT]);
    });
  }

  static Future<Map<String, dynamic>> getQuatOfDayNumbers() async {
    DateTime _myTime = DateTime.now();
    final int offset = await NTP.getNtpOffset(
        localTime: _myTime, lookUpAddress: 'time.google.com');
    var _ntpTime = _myTime.add(Duration(milliseconds: offset));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    if (!prefs.containsKey(PREFS_QUATOFDAY) ||
        prefs.getString(PREFS_QUATOFDAY) == "null") {
      prefs.setString(PREFS_QUATOFDAY, _ntpTime.day.toString());
    }
    if (!prefs.containsKey(PREFS_NUMBEROFMANDALA) ||
        prefs.getString(PREFS_NUMBEROFMANDALA) == "null") {
      prefs.setString(PREFS_NUMBEROFMANDALA, "0");
    }
    if (!prefs.containsKey(PREFS_NUMBEROFQUAT) ||
        prefs.getString(PREFS_NUMBEROFQUAT) == "null") {
      prefs.setString(PREFS_NUMBEROFQUAT, "0");
    }
    if (!prefs.containsKey(PREFS_ISSCRACTHQUAT)) {
      prefs.setBool(PREFS_ISSCRACTHQUAT, false);
    }

    map[PREFS_QUATOFDAY] = prefs.getString(PREFS_QUATOFDAY);
    map[PREFS_NUMBEROFMANDALA] = prefs.getString(PREFS_NUMBEROFMANDALA);
    map[PREFS_NUMBEROFQUAT] = prefs.getString(PREFS_NUMBEROFQUAT);
    map[PREFS_ISSCRACTHQUAT] = prefs.getBool(PREFS_ISSCRACTHQUAT);
    return map;
  }

  static Future<bool> getIsScratchQuat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PREFS_ISSCRACTHQUAT);
  }

  static void saveIsScratchQuat(bool isScratchQuat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PREFS_ISSCRACTHQUAT, isScratchQuat);
  }
}
