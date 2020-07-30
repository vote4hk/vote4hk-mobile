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

class Vote4HKApp extends StatelessWidget {
  final AppLanguage appLanguage;

  // Constructor
  Vote4HKApp({this.appLanguage});

  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MaterialApp(
            locale: model.appLocale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('zh', ''),
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

  WidgetsFlutterBinding.ensureInitialized();

  AppLanguage language = AppLanguage();
  await language.fetchLocale();

  runApp(Vote4HKApp(
    appLanguage: language,
  ));
}
