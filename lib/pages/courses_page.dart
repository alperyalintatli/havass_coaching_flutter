import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/home_page.dart';
import 'package:havass_coaching_flutter/pages/note_page.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_time_provider.dart';
import 'package:provider/provider.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  DateTimeProvider _dateProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dateProvider = Provider.of<DateTimeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Havass"),
                Text(
                  "App",
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: null,
              iconSize: 32,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        child: Container(
            child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.red,
              child: CalendarTimeline(
                initialDate: _dateProvider.dateTime,
                firstDate: _dateProvider.startDate(),
                lastDate: _dateProvider.finishDate(),
                onDateSelected: _dateProvider.setDate,
                leftMargin: 20,
                monthColor: Colors.white,
                dayColor: Colors.teal[200],
                dayNameColor: Color(0xFF333A47),
                activeDayColor: Colors.white,
                activeBackgroundDayColor: Colors.redAccent[100],
                dotsColor: Color(0xFF333A47),
                // selectableDayPredicate: (date) => date.day != 23,
                locale: 'en',
              ),
            ),
            TextButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NotePage())),
                child: Text("Zefyr Text")),
          ],
        )),
      ),
    );
  }
}
