import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';

class IconListWidget extends StatefulWidget {
  final String title;
  final List<IconList> iconList;
  IconListWidget({Key key, @required this.title, @required this.iconList})
      : super(key: key);
  @override
  _IconListWidgetState createState() => _IconListWidgetState();
}

class _IconListWidgetState extends State<IconListWidget> {
  final Color _iconColor = Color.fromARGB(255, 255, 132, 0);
  final Color _iconTextColor = Color.fromARGB(255, 7, 102, 108);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.getString(widget.title),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: _iconTextColor),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.iconList.length,
              itemBuilder: (context, i) {
                return Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    child: FaIcon(
                      widget.iconList[i].icon,
                      color: _iconColor,
                      size: 30,
                    ),
                  ),
                  Text(
                    AppLocalizations.getString(widget.iconList[i].description),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: _iconTextColor),
                  ),
                ]);
              })
        ],
      ),
    );
  }
}

class IconList {
  IconList(this._icon, this._description);
  IconData _icon;
  IconData get icon => this._icon;

  set icon(IconData value) => this._icon = value;

  String _description;
  get description => this._description;

  set description(value) => this._description = value;
}
