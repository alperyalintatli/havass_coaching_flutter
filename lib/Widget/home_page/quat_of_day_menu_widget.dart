import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:share/share.dart';

class QuateOfDayWidget extends StatefulWidget {
  @override
  _QuateOfDayWidgetState createState() => _QuateOfDayWidgetState();
}

class _QuateOfDayWidgetState extends State<QuateOfDayWidget> {
  final _scratchKey = GlobalKey<ScratcherState>();
  bool isGununSozu = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scratcher(
        key: _scratchKey,
        brushSize: 30,
        threshold: 90,
        color: Colors.red,
        image: Image.asset('images/unnamed.jpg'),
        onChange: (value) {
          print(value);
        },
        onThreshold: () {
          setState(() {
            _scratchKey.currentState.reveal();
            isGununSozu = false;
          });
        },
        child: isGununSozu
            ? Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: Color.fromRGBO(154, 206, 207, 1),
                child: Center(child: Text("Buraya bişeyler yazılcak")),
              )
            : Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: Color.fromRGBO(154, 206, 207, 1),
                child: Center(
                    child: RaisedButton(
                  child: Text("aaa"),
                  onPressed: () async {
                    Image.asset('images/unnamed.jpg');

                    final RenderBox box = context.findRenderObject();
                    Share.share('aaa/unnamed.jpg',
                        subject: 'Foloow Me',
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                )),
              ),
      ),
    );
  }
}
