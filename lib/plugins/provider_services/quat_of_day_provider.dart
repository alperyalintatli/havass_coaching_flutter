import 'dart:math';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/firebase_firestore_services/firestore_operations.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';

class QuatOfDayProvider extends ChangeNotifier {
  FireStoreOperation _fireStoreOperation;
  QuatOfDayProvider() {
    _fireStoreOperation = FireStoreOperation.getInstance();
    _getQuatOfNumbers();
  }
  bool _isScratchQuat;
  bool get isScratchQuat => this._isScratchQuat;

  set isScratchQuat(bool value) => this._isScratchQuat = value;
  Map<String, dynamic> _quatMap;
  Map<String, dynamic> get getQuatMap => this._quatMap;

  set setQuatMap(Map<String, dynamic> quatMap) => this._quatMap = quatMap;

  Map<String, String> _mapOfQuatOfDayNumbers;
  Map<String, String> get mapOfQuatOfDayNumbers => this._mapOfQuatOfDayNumbers;

  set mapOfQuatOfDayNumbers(Map<String, String> value) =>
      this._mapOfQuatOfDayNumbers = value;

  void _getQuatOfNumbers() async {
    try {
      _isScratchQuat = true;
      _mapOfQuatOfDayNumbers = await PrefUtils.getQuatOfDayNumbers();
      _quatMap = await _fireStoreOperation.imgQuatList();
      int day = int.parse(_mapOfQuatOfDayNumbers["quatOfDay"]);
      if (day != DateTime.now().day) {
        _mapOfQuatOfDayNumbers["quatOfDay"] = DateTime.now().day.toString();
        _mapOfQuatOfDayNumbers["numberOfMandala"] = _createRandomNumber(
                5, int.parse(_mapOfQuatOfDayNumbers["numberOfMandala"]))
            .toString();
        _mapOfQuatOfDayNumbers["numberOfQuat"] = _createRandomNumber(
                _quatMap.values.length,
                int.parse(_mapOfQuatOfDayNumbers["numberOfQuat"]))
            .toString();
        _isScratchQuat = false;
        PrefUtils.saveQuatOfDayNumbers(_mapOfQuatOfDayNumbers);
      }
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
