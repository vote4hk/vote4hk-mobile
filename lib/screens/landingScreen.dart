import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../routing/routeNames.dart';
import '../locator.dart';
import '../services/navigationService.dart';
import '../widgets/memoItem.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class LandingScreen extends StatefulWidget {
  List<String> menus = ["1", "123", "1235", "654775"];
  String title;
  LandingScreen({Key key, @required this.title});

  @override
  State createState() => new LandingState();
}

class LandingState extends State<LandingScreen> {
  final ScrollController listScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {}

  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    Widget rv = Container(
      child: SafeArea(top: false, bottom: false, child: menuList(context)),
    );
    // for dialog only
    /*
    rv = Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: new Text(
            title,
            style: TextStyle(
                /*color: primaryColor,*/ fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.7,
          actionsIconTheme: Theme.of(context).primaryIconTheme,
        ),
        body: rv);
        */
    return rv;
  }

  void _onTap(String menuItem) async {
    // navigate sample
    /*
    if (menuItem == textRes.USER_SETTING_MENU[0]) {
      locator<NavigationService>()
          .navigateTo('/${MainRoutes[3].route}/${widget.userid}/question');
    }
    if (menuItem == textRes.USER_SETTING_MENU[1]) {
      showDialog<void>(
          context: context,
          //barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return SetUserScreen();
          });
    }
    */
  }

  Widget menuList(BuildContext context) {
    List<Widget> buttonWidgets = [];
    int i = 0;
    widget.menus.forEach((label) {
      buttonWidgets.add(const SizedBox(height: 5.0));
      buttonWidgets.add(MemoItem(label, _onTap, []));
    });
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buttonWidgets));
  }
}
