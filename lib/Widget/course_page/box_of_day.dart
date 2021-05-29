import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/course_pdf_page.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:provider/provider.dart';

class BoxOfDayWidget extends StatelessWidget {
  BoxOfDayWidget(this._day);
  final int _day;
  DateAndNoteProvider _dateProvider;
  HvsUserProvider _hvsUserProvider;

  Widget _boxWidget(String description, BuildContext context) {
    return InkWell(
      onTap: () async {
        String pdfName;
        var realDateNow = await _dateProvider.getRealTime();
        for (var i = 0;
            i < _hvsUserProvider.selectedUserCourse.dates.length;
            i++) {
          String date = realDateNow.day.toString() +
              "." +
              realDateNow.month.toString() +
              "." +
              realDateNow.year.toString();
          if (_hvsUserProvider.selectedUserCourse.dates[i].date == date) {
            if (await PrefUtils.getLanguage() == "en") {
              pdfName = _hvsUserProvider.selectedUserCourse.dates[i].enPdfName;
            } else {
              pdfName = _hvsUserProvider.selectedUserCourse.dates[i].dePdfName;
            }
          }
        }
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CoursePdfPage(
                pdfName,
                //7
                realDateNow != null
                    ? realDateNow.difference(_dateProvider.startDate).inDays
                    : DateTime.now()
                        .difference(_dateProvider.startDate)
                        .inDays)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Card(
          elevation: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.library_add,
                  color: Colors.white,
                ),
              ),
              Container(
                child: Text(
                  description,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          color: Color.fromRGBO(164, 233, 232, 1),
          margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
        ),
        height: 80,
        width: 200,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _dateProvider = Provider.of<DateAndNoteProvider>(context);
    _hvsUserProvider = Provider.of<HvsUserProvider>(context, listen: false);
    switch (_day) {
      case 0:
        return Container(
          margin: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _boxWidget(
                  AppLocalizations.getString("welcome_course_title"), context),
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
                  _day.toString() + ". " + AppLocalizations.getString("day"),
                  context),
            ],
          ),
        );
        break;
    }
  }
}
