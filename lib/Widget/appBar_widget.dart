import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
  final bool isPopup;
  @override
  final Size preferredSize;
  AppBarWidget({
    this.isPopup = true,
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.isPopup
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      toolbarHeight: 70,
      backgroundColor: Color.fromRGBO(164, 233, 232, 1),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Havass"),
              Text(
                "App",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.person,
          //     color: Colors.white,
          //   ),
          //   iconSize: 32,
          // )
        ],
      ),
    );
  }
}
