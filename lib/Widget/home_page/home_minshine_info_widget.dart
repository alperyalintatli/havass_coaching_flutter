import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';

class MindshineInfoWidget extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final String body;
  final String imageName;

  const MindshineInfoWidget({
    Key key,
    @required this.title,
    @required this.body,
    @required this.imageName,
    this.onTap,
  }) : super(key: key);

  @override
  _MindshineInfoWidgetState createState() => _MindshineInfoWidgetState();
}

class _MindshineInfoWidgetState extends State<MindshineInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 25, bottom: 5),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.getString(widget.title),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.width * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  "images/home/${widget.imageName}",
                  fit: BoxFit.fill,
                ),
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 5, bottom: 25, left: 25, right: 25),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.getString(widget.body),
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
