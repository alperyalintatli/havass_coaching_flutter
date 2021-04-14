import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FireStoreOperation {
  static FireStoreOperation _instance;

  FireStoreOperation._internal();

  static FireStoreOperation getInstance() => _instance == null
      ? _instance = FireStoreOperation._internal()
      : _instance;

  Future<List<String>> imgSliderList() async {
    List<String> _list = List<String>();
    firebase_storage.ListResult result = await firebase_storage
        .FirebaseStorage.instance
        .ref('havass_main_page_slider_photo')
        .listAll();
    for (var i = 0; i < result.items.length; i++) {
      var res = await result.items[i].getDownloadURL();
      _list.add(res);
    }
    return _list;
  }
}
