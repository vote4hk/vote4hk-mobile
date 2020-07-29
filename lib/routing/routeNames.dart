import 'package:flutter/material.dart';

class RouteEntry{
  final String route;
  final String label;
  final IconData iconData;
  const RouteEntry(this.route, this.label, this.iconData);
}
const List<RouteEntry> MainRoutes = 
  [RouteEntry('first', '考試', Icons.layers),
  RouteEntry('second', '課程', Icons.dashboard),
  RouteEntry('third', '排行榜', Icons.access_alarm),
  RouteEntry('fourht', '個人', Icons.bookmark)];

