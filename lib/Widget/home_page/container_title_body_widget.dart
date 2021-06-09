import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';

class ContainerTitleBodyWidget extends StatefulWidget {
  final String title;
  final List<String> body;
  final Color backgroundColor;
  ContainerTitleBodyWidget(
      {Key key,
      @required this.title,
      @required this.body,
      @required this.backgroundColor})
      : super(key: key);

  @override
  _ContainerTitleBodyWidgetState createState() =>
      _ContainerTitleBodyWidgetState();
}

class _ContainerTitleBodyWidgetState extends State<ContainerTitleBodyWidget> {
  final Color _textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: widget.backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.getString(widget.title),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: _textColor),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.body.length,
              itemBuilder: (context, i) {
                return Text(
                  AppLocalizations.getString(widget.body[i]),
                  style: TextStyle(fontSize: 15, color: _textColor, height: 2),
                );
              })
        ],
      ),
    );
  }
}
