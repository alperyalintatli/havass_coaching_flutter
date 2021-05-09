import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMeWidget extends StatelessWidget {
  final String _description;
  final bool isDisplay;
  AboutMeWidget(this._description, {this.isDisplay = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              spreadRadius: 1.5,
              blurRadius: 1.5,
              color: Colors.grey.withOpacity(0.2))
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Card(
          elevation: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(right: 10),
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text(
                    //   _title,
                    //   style: TextStyle(fontSize: 20),
                    // ),
                    Text(
                      _description,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    isDisplay
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  const url = 'https://havassacademy.com/';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    NotificationWidget.showNotification(
                                        context,
                                        AppLocalizations.getString(
                                            "not_launch_url"));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 30),
                                  child: Text(
                                    AppLocalizations.getString("about_academy"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(24, 231, 239, 1)),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  const url = 'https://havasscoaching.com/';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    NotificationWidget.showNotification(
                                        context,
                                        AppLocalizations.getString(
                                            "not_launch_url"));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    AppLocalizations.getString(
                                        "about_coaching"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(24, 231, 239, 1)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
              isDisplay
                  ? Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1.5,
                              blurRadius: 1.5,
                              color: Colors.transparent)
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("images/havass_logo_1.png"),
                            fit: BoxFit.cover),
                      ),
                    )
                  : Container(),
            ],
          ),
          // ListTile(
          //   leading: Text("aaa"),
          //   dense: true,
          //   subtitle: Text("basd"),
          //   title: Text("ccc"),
          // ),
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
        ),
      ),
      height: 200,
    );
  }
}
