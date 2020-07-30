import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/layoutTemplate.dart';
import './locator.dart';
import 'services/authService.dart';

//==================This file is the Splash Screen for the app==================
BuildContext _context;
SharedPreferences sharedPreferences;
AuthService authService;

Widget landingMain = Container();
LayoutTemplate layoutTemplate = LayoutTemplate();

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.grey,
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
        primarySwatch:  Colors.blue,
        accentColor: Colors.yellow,
        
        primaryIconTheme: IconThemeData(color: Colors.black),
        primaryTextTheme: TextTheme(
          title: TextStyle(
          color: Colors.black
        )),
        //backgroundColor: Colors.black,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20),
          bodyText1: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16),
          bodyText2: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 12),
          subtitle1: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 10),
          subtitle2: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 8),              
        ),
      );

void main() {
  setupLocator();
  runApp(new MaterialApp(
    onGenerateRoute: getFirstRoute,
    theme: kDefaultTheme, 
    home: new SplashScreen()));
}

Route<dynamic> getFirstRoute(RouteSettings settings) {
  if(settings.name != null) {
    initialRoute = settings.name;
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    //Call the Class constructor and initialize the object
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      authService = new AuthService();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double splashImageSize = 
      (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height) ? 
      MediaQuery.of(context).size.height / 2 :
      MediaQuery.of(context).size.width / 2;
    _context = context;
    //return LayoutTemplate();
    return new Scaffold(
        body: Container(
      color: Colors.yellow,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Image(image: AssetImage('assets/images/Icon-512.png'), width: splashImageSize),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Vote4 HK",
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
            )
          ],
        ),
      ),
    ));
  }
}

void mainNavigationPage() {
  //if (blIsSignedIn) {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(builder: (context) => layoutTemplate,),
    );
}