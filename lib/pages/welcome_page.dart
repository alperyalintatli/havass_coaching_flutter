import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/pages/intro_page.dart';
import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Color.fromARGB(255, 131, 232, 228),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("images/start_page.png"),
              Text(
                "Your Digital Coaching",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        child: RaisedButton(
                          textColor: Color.fromARGB(255, 131, 232, 228),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IntroPage()));
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          color: Colors.white,
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        minWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "I already have an account",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ]),
              )
            ]),
      ),
    ));
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
