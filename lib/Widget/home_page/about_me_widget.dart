import 'package:flutter/material.dart';

class AboutMeWidget extends StatelessWidget {
  final String _title, _description;
  AboutMeWidget(this._title, this._description);
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
      child: Card(
        elevation: 16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _title,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(_description)
                ],
              ),
            ),
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1.5,
                      blurRadius: 1.5,
                      color: Colors.grey.withOpacity(0.2))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("images/person.png"), fit: BoxFit.cover),
              ),
            ),
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
      height: 200,
    );
  }
}
