import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';

class BoxOfDayWidget extends StatelessWidget {
  BoxOfDayWidget(this._day);
  final int _day;

  Widget _boxWidget(String description) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Card(
        elevation: 16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                description,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        color: Color.fromRGBO(164, 233, 232, 1),
        margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
      ),
      height: 80,
      width: 200,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_day) {
      case 0:
        return Container(
          margin: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _boxWidget(AppLocalizations.getString("welcome_course_title")),
            ],
          ),
        );
        break;
      default:
        return Container(
          margin: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _boxWidget(
                  _day.toString() + ". " + AppLocalizations.getString("day")),
            ],
          ),
        );
        break;
    }
  }
}
