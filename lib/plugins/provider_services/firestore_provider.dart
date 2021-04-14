import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/firebase_firestore_services/firestore_operations.dart';

class FirestoreProvider with ChangeNotifier {
  FireStoreOperation fireStoreOperation = FireStoreOperation.getInstance();
  List<String> _homeSliderList;
  List<String> get getHomeSliderList => this._homeSliderList;

  set setHomeSliderList(List<String> homeSliderList) =>
      this._homeSliderList = _homeSliderList;

  void getHomeSlider() async {
    this._homeSliderList = await fireStoreOperation.imgSliderList();
    notifyListeners();
  }

  List<Widget> homeSliderWidgetList(BuildContext context) {
    // _getHomeSlider();
    List<Widget> _list = List<Widget>();
    _homeSliderList.forEach((element) {
      var widget = Stack(
        children: [
          InkResponse(
              child: Image.network(
            element,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ))
        ],
      );
      _list.add(widget);
    });
    if (_list.length == 0) {
      notifyListeners();
      return List<CircularProgressIndicator>();
    } else {
      notifyListeners();
      return _list;
    }
  }
}
