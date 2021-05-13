import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:havass_coaching_flutter/pages/login_page.dart';
import 'package:havass_coaching_flutter/plugins/firebase_auth_services/login_operations.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/aims_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/cart_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/date_and_note_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/firestore_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/navigation_bottom_bar_provider.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/user_provider.dart';
import 'package:ntp/ntp.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'pages/splash_page.dart';
import 'plugins/bloc/bloc_localization.dart';
import 'plugins/provider_services/quat_of_day_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //secureScreen();
    FirebaseMessaging messaging = FirebaseMessaging();
    messaging.requestNotificationPermissions();
    flutterDownloaderInitialize();
    super.initState();
  }

  DateTime _ntpTime;
  void flutterDownloaderInitialize() async {
    DateTime _myTime = DateTime.now();
    final int offset = await NTP.getNtpOffset(
        localTime: _myTime, lookUpAddress: 'time.google.com');
    _ntpTime = _myTime.add(Duration(milliseconds: offset));
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocLocalization>(
          create: (_) => BlocLocalization(),
        )
      ],
      child: BlocBuilder<BlocLocalization, Locale>(
        builder: (context, locale) {
          return OverlaySupport(
              child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => NavBottombarProvider(0)),
              ChangeNotifierProvider(
                  create: (context) => DateAndNoteProvider(_ntpTime)),
              ChangeNotifierProvider(create: (context) => HvsUserProvider()),
              ChangeNotifierProvider(create: (context) => FirestoreProvider()),
              ChangeNotifierProvider(create: (context) => QuatOfDayProvider()),
              ChangeNotifierProvider(create: (context) => AimsProvider()),
              ChangeNotifierProvider(create: (context) => CartProvider()),
            ],
            child: MaterialApp(
              routes: {
                // When navigating to the "/second" route, build the SecondScreen widget.
                '/loginPage': (context) => LoginPage(),
              },
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              home: FirebaseInitialize(),
              locale: locale,
              supportedLocales: [Locale("en"), Locale("de")],
            ),
          ));
        },
      ),
    );
  }

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
}

class FirebaseInitialize extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Hata çıktı:" + snapshot.error.toString()),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          HvsUserProvider _userProvider = Provider.of<HvsUserProvider>(context);
          QuatOfDayProvider _quatOfDayProvider =
              Provider.of<QuatOfDayProvider>(context);
          AimsProvider _aimsProvider = Provider.of<AimsProvider>(context);
          FirestoreProvider _firestoreProvider =
              Provider.of<FirestoreProvider>(context);
          LoginOperations _loginOperation = LoginOperations.getInstance();
          _firestoreProvider.getHomeSlider();
          _quatOfDayProvider.getQuatOfNumbers();
          _aimsProvider.getLang();
          if (_loginOperation.isLoggedIn()) {
            _userProvider.getUser();
          }
          return PageSplash();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
            body: Container(
          child: Text("Havass App"),
          color: Colors.white,
        ));
      },
    );
  }
}
