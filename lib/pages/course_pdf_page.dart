import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:havass_coaching_flutter/widget/notification_widget.dart';
import 'package:provider/provider.dart';

class CoursePdf extends StatefulWidget {
  final String pdfName;
  CoursePdf(this.pdfName);
  @override
  _CoursePdfState createState() => _CoursePdfState(pdfName);
}

class _CoursePdfState extends State<CoursePdf> {
  final String pdfName;
  _CoursePdfState(this.pdfName);
  var itemsToBody = [
    FloatingActionButton(
      backgroundColor: Colors.greenAccent,
      onPressed: () {},
      child: Icon(Icons.add),
    ),
    FloatingActionButton(
      backgroundColor: Colors.indigoAccent,
      onPressed: () {},
      child: Icon(Icons.camera),
    ),
    FloatingActionButton(
      backgroundColor: Colors.orangeAccent,
      onPressed: () {},
      child: Icon(Icons.card_giftcard),
    ),
  ];
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
      document = await PDFDocument.fromAsset('images/$pdfName');
      setState(() => _isLoading = false);
    } catch (e) {
      NotificationWidget.showNotification(
          context, "Bir sorun oluştu. Lütfen tekrar deneyin.");
      await _hvsUserProvider.getUser();
      Navigator.pop(context);
      print(e.toString());
    }
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('images/sample.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
        "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf",
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );
    } else {
      document = await PDFDocument.fromAsset('images/sample.pdf');
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    _hvsUserProvider = Provider.of<HvsUserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 231, 239, 1),
        toolbarHeight: 35,
        title: IconButton(
          icon: Icon(
            Icons.download_sharp,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        titleSpacing: MediaQuery.of(context).size.width * 0.75,
      ),

      // Drawer(
      //   child: Column(
      //     children: <Widget>[
      //       SizedBox(height: 36),
      //       ListTile(
      //         title: Text('Load from Assets'),
      //         onTap: () {
      //           changePDF(1);
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Load from URL'),
      //         onTap: () {
      //           changePDF(2);
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Restore default'),
      //         onTap: () {
      //           changePDF(3);
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 4,
                //uncomment below line to preload all pages
                // lazyLoad: false,
                // uncomment below line to scroll vertically
                scrollDirection: Axis.vertical,
                indicatorPosition: IndicatorPosition.topRight,
                showNavigation: true,
                showPicker: false,

                //uncomment below code to replace bottom navigation with your own
                // navigationBuilder:
                //     (context, page, totalPages, jumpToPage, animateToPage) {
                //   return ButtonBar(
                //     buttonAlignedDropdown: true,
                //     alignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       IconButton(
                //         icon: Icon(Icons.first_page),
                //         onPressed: () {
                //           jumpToPage(page: 0);
                //         },
                //       ),
                //       IconButton(
                //         icon: Icon(Icons.arrow_back),
                //         onPressed: () {
                //           animateToPage(page: page - 2);
                //         },
                //       ),
                //       IconButton(
                //         icon: Icon(Icons.arrow_forward),
                //         onPressed: () {
                //           animateToPage(page: page);
                //         },
                //       ),
                //       IconButton(
                //         icon: Icon(Icons.last_page),
                //         onPressed: () {
                //           jumpToPage(page: totalPages - 1);
                //         },
                //       ),
                //     ],
                //   );
                // },
              ),
      ),
    );
  }
}
