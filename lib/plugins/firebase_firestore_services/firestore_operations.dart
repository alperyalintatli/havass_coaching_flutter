import 'package:havass_coaching_flutter/plugins/firebase_database_services/firebase_database_operations.dart';

class FireStoreOperation {
  static FireStoreOperation _instance;

  FireStoreOperation._internal();
  final DatabaseOperation _databaseOperation = DatabaseOperation.getInstance();
  static FireStoreOperation getInstance() => _instance == null
      ? _instance = FireStoreOperation._internal()
      : _instance;

  Future<Map<String, dynamic>> imgSliderList() async {
    try {
      var result = await _databaseOperation.getSliderListWithDb();
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> imgQuatList() async {
    try {
      var result = await _databaseOperation.getQuatOfImage();
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
