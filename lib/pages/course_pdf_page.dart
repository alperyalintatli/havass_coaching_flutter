import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:badges/badges.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CoursePdfPage extends StatefulWidget {
  final String pdfName;
  final int numberofDay;
  CoursePdfPage(this.pdfName, this.numberofDay);
  @override
  _CoursePdfPageState createState() =>
      _CoursePdfPageState(pdfName, numberofDay);
}

class _CoursePdfPageState extends State<CoursePdfPage> {
  final String pdfName;
  final int numberofDay;
  _CoursePdfPageState(this.pdfName, this.numberofDay);
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  HvsUserProvider _hvsUserProvider;
  loadDocument() async {
    try {
      document = await PDFDocument.fromAsset('images/pdf/$pdfName.pdf');
      setState(() => _isLoading = false);
    } catch (e) {
      NotificationWidget.showNotification(
          context,
          AppLocalizations.getString(
              "userName_change_notification_error_title")); //Bir sorun oluştu lütfen tekrar deneyin hatası
      await _hvsUserProvider.getUser();
      Navigator.pop(context);
      print(e.toString());
    }
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  @override
  Widget build(BuildContext context) {
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    var downloadCourseName = pdfName.split("_")[2];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 231, 239, 1),
        toolbarHeight: 35,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            (numberofDay == 7 ||
                    (numberofDay == 12 && downloadCourseName == "16") ||
                    (numberofDay == 14 && downloadCourseName == "28") ||
                    numberofDay == 21)
                ? Badge(
                    badgeColor: Colors.red,
                    position: BadgePosition.topEnd(end: 10, top: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.download_sharp,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        try {
                          var permission = await Permission.storage.request();
                          if (!permission.isDenied) {
                            var path;
                            if (Platform.isAndroid) {
                              path = await ExtStorage
                                  .getExternalStoragePublicDirectory(
                                      ExtStorage.DIRECTORY_DOWNLOADS);
                              path = Directory(path);
                              //path = await getExternalStorageDirectory();
                            } else if (Platform.isIOS) {
                              path = await getLibraryDirectory();
                            }
                            if (await path.exists()) {
                              var locale = await PrefUtils.getLanguage();
                              final taskId = await FlutterDownloader.enqueue(
                                  url: (downloadCourseName == "16")
                                      ? (locale == 'en')
                                          ? Constants
                                              .COURSE_DAY_OF_16_PDF_URL_en
                                          : Constants
                                              .COURSE_DAY_OF_16_PDF_URL_de
                                      : (locale == 'en')
                                          ? Constants
                                              .COURSE_DAY_OF_28_PDF_URL_en
                                          : Constants
                                              .COURSE_DAY_OF_28_PDF_URL_de,
                                  savedDir: path.path,
                                  showNotification:
                                      true, // show download progress in status bar (for Android)
                                  openFileFromNotification:
                                      true, // click on notification to open downloaded file (for Android)
                                  fileName: (downloadCourseName == "16")
                                      ? (locale == 'en')
                                          ? Constants
                                              .COURSE_DAY_OF_16_PDF_NAME_en
                                          : Constants
                                                  .COURSE_DAY_OF_16_PDF_NAME_de +
                                              ".pdf"
                                      : (locale == 'en')
                                          ? Constants
                                              .COURSE_DAY_OF_28_PDF_NAME_en
                                          : Constants
                                                  .COURSE_DAY_OF_28_PDF_NAME_de +
                                              ".pdf");
                              taskId != null
                                  ? NotificationWidget.showNotification(
                                      context,
                                      AppLocalizations.getString(
                                          "pdf_download_success"))
                                  : print(taskId);
                            }
                          }
                        } catch (e) {
                          NotificationWidget.showNotification(context,
                              AppLocalizations.getString("pdf_download_eror"));
                        }

//FlutterDownloader.registerCallback(callback);

                        // We didn't ask for permission yet or the permission has been denied before but not permanently.
                        // final bytes =
                        //     await rootBundle.load('images/course_of_16_en_0.pdf');
                        // String path =
                        //     await ExtStorage.getExternalStoragePublicDirectory(
                        //         ExtStorage.DIRECTORY_DOWNLOADS);
                        // var filePath = "$path/course_of_16_en_0.pdf";
                        // await writeToFile(bytes, filePath);
                        // NotificationWidget.showNotification(context, "deneme5");
                      },
                    ),
                  )
                : Icon(
                    Icons.download_sharp,
                    color: Colors.grey,
                  ),
          ],
        ),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 4,
                scrollDirection: Axis.vertical,
                indicatorPosition: IndicatorPosition.topRight,
                showNavigation: true,
                showPicker: false,
                navigationBuilder:
                    (context, page, totalPages, jumpToPage, animateToPage) {
                  return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page_outlined),
                          onPressed: () {
                            jumpToPage(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_upward),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        )
                      ]);
                }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
