import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/courses.dart';
import 'package:havass_coaching_flutter/pages/past_courses_page.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/appBar_widget.dart';
import 'package:havass_coaching_flutter/widget/course_info_widget.dart';
import 'package:havass_coaching_flutter/widget/settings_drawer_widget.dart';
import 'package:provider/provider.dart';

class PastCoursesListPage extends StatefulWidget {
  @override
  _PastCoursesListPageState createState() => _PastCoursesListPageState();
}

class _PastCoursesListPageState extends State<PastCoursesListPage> {
  HvsUserProvider _hvsUserProvider;
  DateAndNoteProvider _dateAndNoteProvider;
  Future<List<Course>> getCourses() async {
    List<Course> courses = List<Course>();
    var realDateNow = await _dateAndNoteProvider.getRealTime();
    _hvsUserProvider.getHvsUser.course.forEach((course) {
      var termDate = DateTime(
          int.parse(
            course.getTerminationDate.split('.')[2],
          ),
          int.parse(course.getTerminationDate.split('.')[1]),
          int.parse(course.getTerminationDate.split('.')[0]));
      if (realDateNow.isAfter(termDate)) {
        courses.add(course);
      }
    });
    return courses;
  }

  @override
  Widget build(BuildContext context) {
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    _dateAndNoteProvider = Provider.of<DateAndNoteProvider>(context);
    getCourses();
    return Scaffold(
        appBar: AppBarWidget(),
        endDrawer: SettingsDrawerWidget(),
        body: FutureBuilder<List<Course>>(
            future: getCourses(),
            builder: (context, AsyncSnapshot<List<Course>> snapshot) {
              if (!snapshot.hasData) {
                // while data is loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // data loaded:
                final courseList = snapshot.data;
                if (courseList.length < 1) {
                  return Center(
                    child: Container(
                      child: Text(
                          AppLocalizations.getString("course_not_found_text")),
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: courseList.length,
                    itemBuilder: (ctxt, index) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _hvsUserProvider.getUser();
                                _hvsUserProvider
                                    .getUserCourse(courseList[index]);
                                var startDate = _hvsUserProvider
                                    .selectedUserCourse.getRegisterDate
                                    .split(".");
                                var finishDate = _hvsUserProvider
                                    .selectedUserCourse.getTerminationDate
                                    .split(".");
                                _dateAndNoteProvider.setOldCourseDate(
                                    DateTime(
                                        int.parse(startDate[2].toString()),
                                        int.parse(startDate[1].toString()),
                                        int.parse(startDate[0].toString())),
                                    DateTime(
                                        int.parse(finishDate[2].toString()),
                                        int.parse(finishDate[1].toString()),
                                        int.parse(finishDate[0].toString())));
                                _dateAndNoteProvider.setOldDate(
                                    DateTime(
                                        int.parse(startDate[2].toString()),
                                        int.parse(startDate[1].toString()),
                                        int.parse(startDate[0].toString())),
                                    courseList[index].courseIdName);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PastCoursePage()));
                              },
                              child: Container(
                                child: CourseInfoViewWidget(
                                  courseName: AppLocalizations.getString(
                                      courseList[index].courseIdName),
                                  day:
                                      "${courseList[index].getRegisterDate} - ${courseList[index].getTerminationDate}",
                                  imagePath:
                                      "images/${courseList[index].courseIdName}_photo.jpg",
                                  price: "",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
            }));
  }
}
