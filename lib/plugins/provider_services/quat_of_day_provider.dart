import 'dart:math';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/firebase_firestore_services/firestore_operations.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';

class QuatOfDayProvider extends ChangeNotifier {
  FireStoreOperation _fireStoreOperation;
  QuatOfDayProvider() {
    _fireStoreOperation = FireStoreOperation.getInstance();
  }
  bool _isScratchQuat;
  bool get isScratchQuat {
    notifyListeners();
    return this._isScratchQuat;
  }

  set isScratchQuat(bool value) => this._isScratchQuat = value;

  Map<String, dynamic> _quatMap;
  Map<String, dynamic> get getQuatMap {
    notifyListeners();
    return this._quatMap;
  }

  set setQuatMap(Map<String, dynamic> quatMap) => this._quatMap = quatMap;

  Map<String, dynamic> _mapOfQuatOfDayNumbers;
  Map<String, dynamic> get mapOfQuatOfDayNumbers {
    notifyListeners();
    return this._mapOfQuatOfDayNumbers;
  }

  set mapOfQuatOfDayNumbers(Map<String, dynamic> value) =>
      this._mapOfQuatOfDayNumbers = value;

  void getQuatOfNumbers() async {
    try {
      _mapOfQuatOfDayNumbers = await PrefUtils.getQuatOfDayNumbers();
      _isScratchQuat = _mapOfQuatOfDayNumbers[PrefUtils.PREFS_ISSCRACTHQUAT];
      _quatMap = await _fireStoreOperation.imgQuatList();
      int day = int.parse(_mapOfQuatOfDayNumbers[PrefUtils.PREFS_QUATOFDAY]);
      if (day != DateTime.now().day) {
        _mapOfQuatOfDayNumbers[PrefUtils.PREFS_QUATOFDAY] =
            DateTime.now().day.toString();
        _mapOfQuatOfDayNumbers[
            PrefUtils.PREFS_NUMBEROFMANDALA] = _createRandomNumber(
                5,
                int.parse(
                    _mapOfQuatOfDayNumbers[PrefUtils.PREFS_NUMBEROFMANDALA]))
            .toString();
        _mapOfQuatOfDayNumbers[PrefUtils.PREFS_NUMBEROFQUAT] =
            _createRandomNumber(
                    _quatMap.values.length,
                    int.parse(
                        _mapOfQuatOfDayNumbers[PrefUtils.PREFS_NUMBEROFQUAT]))
                .toString();
        _mapOfQuatOfDayNumbers[PrefUtils.PREFS_ISSCRACTHQUAT] = false;
        _isScratchQuat = false;
        PrefUtils.saveQuatOfDayNumbers(_mapOfQuatOfDayNumbers);
      }
    } catch (e) {
      print(e);
    }
  }

  void saveIsScracthQuat() async {
    try {
      _isScratchQuat = true;
      _mapOfQuatOfDayNumbers[PrefUtils.PREFS_ISSCRACTHQUAT] = true;
      PrefUtils.saveQuatOfDayNumbers(_mapOfQuatOfDayNumbers);
    } catch (e) {
      print(e);
    }
  }

  int _createRandomNumber(int lenght, int notInNumber) {
    bool isSuccess = false;
    var rng = new Random();
    int number;
    while (isSuccess == false) {
      number = rng.nextInt(lenght);
      if (number != notInNumber) {
        isSuccess = true;
      }
    }
    return number;
  }
}
