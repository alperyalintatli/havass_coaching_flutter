import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/register_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignUpPage()),
    );
  }

  // Widget _buildFullscrenImage() {
  //   return Image.asset(
  //     'images/back_0.png',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

  // Widget _buildImage(String assetName, [double width = 350]) {
  //   return Image.asset('assets/$assetName', width: width);
  // }

  Widget checkBoxButton({@required String text, @required String imageName}) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: RaisedButton(
        textColor: Color.fromARGB(255, 131, 232, 228),
        onPressed: () {
          introKey.currentState.controller.page ==
                  introKey.currentState.widget.pages.length - 1
              ? introKey.currentState.widget.onDone()
              : introKey.currentState.next();
        },
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.black)),
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Tab(
                    icon: Image.asset("images/$imageName.png"),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.75,
      height: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
              title: "What main goal do you want to achieve with Havass MeApp",
              body:
                  "Optionally, you can select your preferences for a personalised experience",
              // image: _buildImage('img1.jpg'),
              decoration: pageDecoration,
              footer: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  checkBoxButton(
                      text: "Feel Happier", imageName: "feel_happier_image"),
                  checkBoxButton(
                      text: "Release Stress & gain inner calm",
                      imageName: "release_stress_image"),
                  checkBoxButton(text: "Focus", imageName: "focus_image"),
                  checkBoxButton(
                      text: "Lose weight & gain body confidence",
                      imageName: "loose_weight_image"),
                  checkBoxButton(
                      text: "Find motivation",
                      imageName: "find_motivation_image"),
                  checkBoxButton(
                      text: "Let go of depression or anxiety",
                      imageName: "depression_anxiety_image"),
                ],
              )),
          PageViewModel(
            title: "",
            bodyWidget: Text(
              "I am ...",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            // image: _buildImage('img2.jpg'),
            footer: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.0,
                ),
                checkBoxButton(text: "Female", imageName: "female_image"),
                checkBoxButton(text: "Male", imageName: "male_image"),
                checkBoxButton(text: "Other", imageName: "other_image"),
              ],
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: false,
        isProgress: true,
        skipFlex: 0,
        nextFlex: 0,
        //rtl: true, // Display as right-to-left
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),

        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeColor: Color.fromARGB(255, 131, 232, 228),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }

  // Widget _submitButton() {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => LoginPage()));
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       padding: EdgeInsets.symmetric(vertical: 13),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(Radius.circular(5)),
  //           boxShadow: <BoxShadow>[
  //             BoxShadow(
  //                 color: Color(0xffdf8e33).withAlpha(0),
  //                 offset: Offset(2, 4),
  //                 blurRadius: 8,
  //                 spreadRadius: 2)
  //           ],
  //           color: Colors.white),
  //       child: Text(
  //         AppLocalizations.getString("login"),
  //         style: TextStyle(fontSize: 20, color: Color.fromRGBO(72, 72, 72, 1)),
  //       ),
  //     ),
  //   );
  // }

  // Widget _signUpButton() {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => SignUpPage()));
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       padding: EdgeInsets.symmetric(vertical: 13),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(5)),
  //         border: Border.all(color: Colors.white, width: 2),
  //       ),
  //       child: Text(
  //         AppLocalizations.getString("register_now"),
  //         style: TextStyle(fontSize: 20, color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  // Widget _title() {
  //   return RichText(
  //     textAlign: TextAlign.center,
  //     text: TextSpan(
  //         text: 'Ha',
  //         style: TextStyle(
  //           fontSize: 30,
  //           fontWeight: FontWeight.w700,
  //           color: Colors.white,
  //         ),
  //         children: [
  //           TextSpan(
  //             text: 'va',
  //             style:
  //                 TextStyle(color: Color.fromRGBO(72, 72, 72, 1), fontSize: 30),
  //           ),
  //           TextSpan(
  //             text: 'ss',
  //             style: TextStyle(color: Colors.white, fontSize: 30),
  //           ),
  //         ]),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 20),
  //         height: MediaQuery.of(context).size.height,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(5)),
  //             boxShadow: <BoxShadow>[
  //               BoxShadow(
  //                   color: Colors.grey.shade200,
  //                   offset: Offset(2, 4),
  //                   blurRadius: 5,
  //                   spreadRadius: 2)
  //             ],
  //             gradient: LinearGradient(
  //                 begin: Alignment.topCenter,
  //                 end: Alignment.bottomCenter,
  //                 colors: [
  //                   Color.fromRGBO(164, 233, 232, 1),
  //                   Color.fromARGB(0, 121, 250, 0)
  //                 ])),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             _title(),
  //             SizedBox(
  //               height: 80,
  //             ),
  //             _submitButton(),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             _signUpButton(),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 IconButton(
  //                     icon: Image.asset('images/english-flag-icon.png'),
  //                     onPressed: () async {
  //                       FirebaseMessaging _f = FirebaseMessaging();
  //                       await _f.subscribeToTopic("en");
  //                       await _f.unsubscribeFromTopic("de");
  //                       setState(() {
  //                         BlocProvider.of<BlocLocalization>(context)
  //                             .add(LocaleEvent.EN);
  //                       });
  //                     }),
  //                 IconButton(
  //                     icon: Image.asset('images/german-flag-icon.png'),
  //                     onPressed: () async {
  //                       FirebaseMessaging _f = FirebaseMessaging();
  //                       await _f.subscribeToTopic("de");
  //                       await _f.unsubscribeFromTopic("en");
  //                       setState(() {
  //                         BlocProvider.of<BlocLocalization>(context)
  //                             .add(LocaleEvent.DE);
  //                       });
  //                     }),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
