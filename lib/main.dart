import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote4hk_mobile/i18n/app_language.dart';
import 'package:vote4hk_mobile/i18n/app_localizations.dart';
import 'package:vote4hk_mobile/services/user_service.dart';
import 'pages/home_page.dart';
import 'package:provider/provider.dart';

//==================This file is the Splash Screen for the app==================
BuildContext _context;

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
                textTheme: TextTheme(
                  headline1:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  headline6:
                      TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  bodyText1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
                  bodyText2: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Hind',
                      color: Color.fromRGBO(0, 0, 0, 1.0)),
                  caption: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Hind',
                      color: Color.fromRGBO(0, 0, 0, 0.6)),
                )),
            home: HomePage(),
            routes: <String, WidgetBuilder>{
              '/home': (BuildContext context) => HomePage(),
            },
            //initialRoute: '/login',
          );
        }));
  }
}

Future<void> initFirestoreSettings() async {
  Firestore firestore = Firestore();
  await firestore.settings(persistenceEnabled: true);
  userService = UserService();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirestoreSettings();
  AppLanguage language = AppLanguage();
  await language.fetchLocale();

  runApp(Vote4HKApp(
    appLanguage: language,
  ));
}
