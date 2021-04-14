import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:havass_coaching_flutter/plugins/firebase_database_services/firebase_database_operations.dart';

class FireStoreOperation {
  static FireStoreOperation _instance;

  FireStoreOperation._internal();
  final DatabaseOperation _databaseOperation = DatabaseOperation.getInstance();
  static FireStoreOperation getInstance() => _instance == null
      ? _instance = FireStoreOperation._internal()
      : _instance;

  Future<Map<String, dynamic>> imgSliderList() async {
    // List<String> _list = List<String>();
    // firebase_storage.ListResult result = await firebase_storage
    //     .FirebaseStorage.instance
    //     .ref('havass_main_page_slider_photo')
    //     .listAll();
    // for (var i = 0; i < result.items.length; i++) {
    //   var res = await result.items[i].getDownloadURL();
    //   _list.add(res);
    // }
    //return _list;
    try {
      var result = await _databaseOperation.getSliderListWithDb();
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> imgQuatList() async {
    try {
      var result = await _databaseOperation.getQuatOfImage();
      return result;
    } catch (e) {
      print(e);
    }
  }
}
