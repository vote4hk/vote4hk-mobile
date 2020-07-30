//import 'package:OurlandQuiz/models/textRes.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './routeNames.dart';
import '../screens/landingScreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  String route = MainRoutes[0].route;
  List<String> path = [route];
  print(settings.arguments);
  print(settings.name);
  if (settings != null) {
    if (settings.name != null) {
      path = Uri.decodeFull(Uri.parse(settings.name).toString()).split("/");
      //print(path);
      if (path.length > 1) {
        route = path[1];
      }
    }
  }
  if (route == MainRoutes[1].route) {
    return _getPageRoute(LandingScreen(title: MainRoutes[1].route), '/' + route);
  }
  if (route == MainRoutes[2].route) {
    return _getPageRoute(LandingScreen(title: MainRoutes[2].route), '/' + MainRoutes[2].route);
  }
  if (route == MainRoutes[3].route) {
    return _getPageRoute(LandingScreen(title: MainRoutes[3].route), '/' + MainRoutes[3].route);
  }
  return _getPageRoute(LandingScreen(title: MainRoutes[0].route), '/' + MainRoutes[0].route);
}

PageRoute _getPageRoute(Widget child, String routeName) {
  return _FadeRoute(child: child, routeName: routeName);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                child,
            settings: RouteSettings(name: routeName),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}
