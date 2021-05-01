import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/firebase_firestore_services/firestore_operations.dart';

class FirestoreProvider with ChangeNotifier {
  FireStoreOperation fireStoreOperation = FireStoreOperation.getInstance();
  Map<String, dynamic> _homeSliderList;
  Map<String, dynamic> get getHomeSliderList => this._homeSliderList;

  set setHomeSliderList(Map<String, dynamic> homeSliderList) =>
      this._homeSliderList = _homeSliderList;

  void getHomeSlider() async {
    this._homeSliderList = await fireStoreOperation.imgSliderList();
    notifyListeners();
  }

  List<Widget> homeSliderList;
  void homeSliderWidgetList(BuildContext context) {
    // List<Widget> _list = List<Widget>();
    // _homeSliderList.forEach((element) {
    //   var widget = Stack(
    //     children: [
    //       InkResponse(
    //           child: Image.network(
    //         element,
    //         fit: BoxFit.cover,
    //         width: MediaQuery.of(context).size.width,
    //       ))
    //     ],
    //   );
    //   _list.add(widget);
    // });
    // if (_list.length != 0) {
    //   notifyListeners();
    //   homeSliderList = _list;
    // }
    List<Widget> _list = List<Widget>();
    _homeSliderList.forEach((key, value) {
      var widget = Stack(
        children: [
          GestureDetector(
            onTap: null,
            // () async {
            //   if (await canLaunch(value)) {
            //     await launch(value);
            //   } else {
            //     Navigator.pushNamed(context, value);
            //   }
            // },
            child: InkResponse(
              child: CachedNetworkImage(
                imageUrl: key.toString(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              // Image.network(
              //   key.toString(),
              //   fit: BoxFit.cover,
              //   width: MediaQuery.of(context).size.width,
              // ),
            ),
          )
        ],
      );
      _list.add(widget);
    });
    if (_list.length != 0) {
      notifyListeners();
      homeSliderList = _list;
    }
  }
}
