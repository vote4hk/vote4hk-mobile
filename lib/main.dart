import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home_page.dart';

//==================This file is the Splash Screen for the app==================
BuildContext _context;
SharedPreferences sharedPreferences;

class Vote4HKApp extends StatefulWidget {
  // Constructor
  OIBSApp() {}

  @override
  State<StatefulWidget> createState() => _Vote4HKAppState();
}

class _Vote4HKAppState extends State<Vote4HKApp> {
  // TODO: add init data fetch bloc
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale.fromSubtags(languageCode: 'zh'),
      ],
      theme: ThemeData(
        buttonColor: Colors.blueAccent,
        textSelectionColor: Colors.grey[700],
        textSelectionHandleColor: Colors.grey[400],
        cursorColor: Colors.white, // for text color
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
      },
      initialRoute: '/login',
    );
  }
}

void main() {
  runApp(Vote4HKApp());
}