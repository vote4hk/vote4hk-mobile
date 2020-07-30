import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vote4hk_mobile/i18n/app_language.dart';
import 'package:vote4hk_mobile/i18n/app_localizations.dart';
import 'pages/home_page.dart';
import 'package:provider/provider.dart';

//==================This file is the Splash Screen for the app==================
BuildContext _context;
SharedPreferences sharedPreferences;

class Vote4HKApp extends StatefulWidget {
  final AppLanguage appLanguage;

  // Constructor
  Vote4HKApp({this.appLanguage});

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
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => widget.appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale.fromSubtags(languageCode: 'zh'),
            ],
            theme: ThemeData(
              primaryColor: Color.fromRGBO(77, 83, 147, 1),
              cursorColor: Colors.white, // for text color
            ),
            home: HomePage(),
            routes: <String, WidgetBuilder>{
              '/home': (BuildContext context) => HomePage(),
            },
            initialRoute: '/login',
          );
        }));
  }
}

void main() async {
  AppLanguage language = AppLanguage();
  await language.fetchLocale();

  runApp(Vote4HKApp(
    appLanguage: language,
  ));
}
