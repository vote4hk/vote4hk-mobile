import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../locator.dart';
import '../routing/routeNames.dart';
import '../routing/router.dart';
import '../services/navigationService.dart';
import '../widgets/centeredView.dart';
import '../widgets/navigationBar.dart';
import '../widgets/navigationDrawer.dart';

String initialRoute = '/';

class LayoutTemplate extends StatefulWidget {
  LayoutTemplateState _state;
  LayoutTemplate({Key key}) : super(key: key);
    @override
  State createState() {
    _state = new LayoutTemplateState();
    return _state;
  } 
  void showNaviBar(bool show) {
    _state.showNaviBar(show);
  }

}

class LayoutTemplateState extends State<LayoutTemplate> {
  bool isShowNavigatorBar = true;
  void showNaviBar(bool show) {
    setState(() {
      isShowNavigatorBar = show;
    });
  }
  @override
  Widget build(BuildContext context) {
    print('Layout $isShowNavigatorBar');
    return ResponsiveBuilder(
      builder: (context, sizingInformation) { 
        Scaffold scaffold = Scaffold(
          drawer: NavigationDrawer(),
          appBar: new AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: new Text(
            "vote4.hk",
            style: TextStyle(
                /*color: primaryColor,*/ fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.7,
          actionsIconTheme: Theme.of(context).primaryIconTheme,
        ),
          backgroundColor: Colors.white,
          body: CenteredView(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Navigator(
                    key: locator<NavigationService>().navigatorKey,
                    onGenerateRoute: generateRoute,
                    initialRoute: initialRoute,
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: this.isShowNavigatorBar ? NavigationBar(): null,
          /*
          bottomNavigationBar: sizingInformation.deviceScreenType != DeviceScreenType.Mobile ?
          NavigationBar(): null,
          */
        );
        return scaffold;
      }
    );
  }
}