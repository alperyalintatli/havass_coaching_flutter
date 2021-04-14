import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/quat_of_day_provider.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/scratcher.dart';

class QuateOfDayWidget extends StatefulWidget {
  @override
  _QuateOfDayWidgetState createState() => _QuateOfDayWidgetState();
}

class _QuateOfDayWidgetState extends State<QuateOfDayWidget> {
  QuatOfDayProvider _quatOfDayProvider;
  @override
  Widget build(BuildContext context) {
    _quatOfDayProvider = Provider.of<QuatOfDayProvider>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(Icons.bathtub_sharp),
                  onPressed: null,
                  disabledColor: Colors.white,
                ),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(154, 206, 207, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5))
                    ]),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  "Heutige Affirmationen",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(154, 206, 207, 1),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5))
                    ]),
              ),
              Container(
                width: 40.0,
                height: 40.0,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: PopupMenuButton(
                    elevation: 8,
                    offset: Offset.lerp(Offset(30, 0), Offset(0, 30), 10),
                    captureInheritedThemes: true,
                    color: Color.fromRGBO(154, 206, 207, 1),
                    icon: Icon(Icons.info_outline_rounded, color: Colors.white),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Container(
                                child: Text(
                                  "Ekran Ekran Ekran Ekran Ekran EkranEkranEkranEkran Ekran EkranEkran Ekran Ekran Ekran",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              value: "/newchat"),
                        ]),
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5))
                    ]),
              )
            ],
          ),
          _quatOfDayProvider.isScratchQuat
              ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height - 350,
                  width: MediaQuery.of(context).size.width - 10,
                  color: Color.fromRGBO(154, 206, 207, 1),
                  child: Center(
                      child: Image.network(_quatOfDayProvider.getQuatMap[
                          _quatOfDayProvider.mapOfQuatOfDayNumbers[
                              PrefUtils.PREFS_NUMBEROFQUAT]])),
                )
              : Scratcher(
                  brushSize: 30,
                  threshold: 85,
                  color: Colors.white,
                  image: Image.asset(
                      'images/mandala_images/mandala_${_quatOfDayProvider.mapOfQuatOfDayNumbers[PrefUtils.PREFS_NUMBEROFMANDALA]}.jpg'),
                  onChange: (value) {
                    print(value);
                  },
                  onThreshold: () {
                    setState(() {
                      _quatOfDayProvider.saveIsScracthQuat();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height - 350,
                    width: MediaQuery.of(context).size.width - 10,
                    color: Color.fromRGBO(154, 206, 207, 1),
                    child: Center(
                        child: Image.network(_quatOfDayProvider.getQuatMap[
                            _quatOfDayProvider.mapOfQuatOfDayNumbers[
                                PrefUtils.PREFS_NUMBEROFQUAT]])),
                  )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                margin: EdgeInsets.all(20),
                child: IconButton(
                  icon: Row(
                    children: [
                      Icon(
                        Icons.share_sharp,
                        color: _quatOfDayProvider.isScratchQuat
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                      Container(
                        child: Text(
                          "Share",
                          style: TextStyle(
                              fontSize: 15,
                              color: _quatOfDayProvider.isScratchQuat
                                  ? Colors.white
                                  : Colors.grey.shade500),
                        ),
                        margin: EdgeInsets.only(left: 5),
                      )
                    ],
                  ),
                  onPressed: _quatOfDayProvider.isScratchQuat ? () {} : null,
                ),
                decoration: BoxDecoration(
                    color: _quatOfDayProvider.isScratchQuat
                        ? Color.fromRGBO(24, 231, 239, 1)
                        : Colors.grey.shade300,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5))
                    ]),
              )
            ],
          )
        ],
      ),
    );
  }
}