import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/quat_of_day_provider.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/scratcher.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:http/http.dart' as http;

class QuateOfDayWidget extends StatefulWidget {
  @override
  _QuateOfDayWidgetState createState() => _QuateOfDayWidgetState();
}

class _QuateOfDayWidgetState extends State<QuateOfDayWidget> {
  QuatOfDayProvider _quatOfDayProvider;
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool _isShare = false;

  Widget quatImage() {
    return CachedNetworkImage(
      imageUrl: _quatOfDayProvider.getQuatMap[_quatOfDayProvider
          .mapOfQuatOfDayNumbers[PrefUtils.PREFS_NUMBEROFQUAT]],
      placeholder: (context, url) => new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  final List<String> playList = ["audio_1", "audio_2", "audio_3", "audio_4"];
  final List<String> playListName = [
    AppLocalizations.getString("love"),
    AppLocalizations.getString("self-awareness"),
    AppLocalizations.getString("self-confidence"),
    AppLocalizations.getString("motivation")
  ];
  int playListIndex;
  void changePlayListIndex(int index) {
    setState(() {
      playListIndex = index;
    });
  }

  void closePlayListIndex() {
    setState(() {
      playListIndex = null;
    });
  }

  // bool _isPaused = true;
  @override
  Widget build(BuildContext context) {
    _quatOfDayProvider = Provider.of<QuatOfDayProvider>(context);
    _quatOfDayProvider.getQuatOfNumbers();
    return Container(
      child: SingleChildScrollView(
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
                    AppLocalizations.getString("heutige_affirmationen"),
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
                      offset: Offset.lerp(Offset(30, 0), Offset(0, 30), 2),
                      //captureInheritedThemes: true,
                      color: Color.fromRGBO(154, 206, 207, 1),
                      icon: FaIcon(FontAwesomeIcons.info, color: Colors.white),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                child: Container(
                                  child: Text(
                                    AppLocalizations.getString(
                                        "heutige_affirmationen_popup"),
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
                    height: MediaQuery.of(context).size.width + 15,
                    width: MediaQuery.of(context).size.width + 15,
                    color: Color.fromRGBO(0, 244, 245, 1),
                    child: Center(
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.center, child: quatImage()),
                        ],
                      ),
                    ),
                  )
                : Scratcher(
                    brushSize: 30,
                    threshold: 50,
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
                      height: MediaQuery.of(context).size.width + 15,
                      width: MediaQuery.of(context).size.width + 15,
                      color: Color.fromRGBO(0, 244, 245, 1),
                      child: Center(
                        child: quatImage(),
                      ),
                    ),
                  ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      margin: EdgeInsets.all(20),
                      child: IconButton(
                        icon: !_isShare
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.share_sharp,
                                    color: _quatOfDayProvider.isScratchQuat
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                  ),
                                  Container(
                                    child: Text(
                                      AppLocalizations.getString(
                                          "share_button_text"),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              _quatOfDayProvider.isScratchQuat
                                                  ? Colors.white
                                                  : Colors.grey.shade500),
                                    ),
                                    margin: EdgeInsets.only(left: 5),
                                  )
                                ],
                              )
                            : CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white)),
                        onPressed: _quatOfDayProvider.isScratchQuat
                            ? () async {
                                try {
                                  setState(() {
                                    _isShare = true;
                                  });
                                  http.Response response = await http.get(
                                    _quatOfDayProvider.getQuatMap[
                                        _quatOfDayProvider
                                                .mapOfQuatOfDayNumbers[
                                            PrefUtils.PREFS_NUMBEROFQUAT]],
                                  );

                                  if (response != null) {
                                    await WcFlutterShare.share(
                                      sharePopupTitle: 'Havass Me App',
                                      subject: 'Havass Coaching & Academy',
                                      text: 'Havass Coaching & Academy',
                                      fileName: 'havassMeApp.jpg',
                                      mimeType: 'image/jpeg',
                                      bytesOfFile: response.bodyBytes,
                                    );

                                    setState(() {
                                      _isShare = false;
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            : null,
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
                ),
              ),
            ]),
            Container(
                margin:
                    EdgeInsets.only(top: 50, bottom: 10, left: 10, right: 10),
                height: MediaQuery.of(context).size.width * 0.9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    "images/home/affirmation.png",
                    fit: BoxFit.fill,
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 25, bottom: 5),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.getString("subliminal_title"),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 5, bottom: 25, left: 25, right: 25),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.getString("subliminal_body"),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 5, bottom: 25, left: 15, right: 25),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: playList.length,
                  itemBuilder: (context, i) {
                    return Row(
                      children: [
                        IconButton(
                          iconSize: 32.0,
                          color: Color.fromRGBO(255, 132, 0, 1),
                          icon: Icon(
                              (playListIndex != null && i == playListIndex)
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow),
                          onPressed: () async {
                            if (i == playListIndex) {
                              await assetsAudioPlayer.pause();
                              closePlayListIndex();
                            } else {
                              await assetsAudioPlayer.pause();
                              await assetsAudioPlayer.open(
                                Audio("images/audio/audio_$i.mp3"),
                                autoStart: false,
                                showNotification: true,
                              );
                              await assetsAudioPlayer.play();
                              changePlayListIndex(i);
                            }
                          },
                        ),
                        Text(
                          playListName[i],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }
}
