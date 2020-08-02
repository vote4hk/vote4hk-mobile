import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vote4hk_mobile/blocs/app_bloc.dart';
import 'package:vote4hk_mobile/i18n/app_language.dart';
import 'package:vote4hk_mobile/i18n/app_localizations.dart';
import 'package:vote4hk_mobile/models/case.dart';
import 'package:vote4hk_mobile/widgets/stateless/case_card.dart';
import 'package:vote4hk_mobile/services/user_service.dart';

// TODO: move this to case page
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  AnimationController _fadeController;
  Animation _fadeAnimation;
  SharedPreferences _sharedPreferences;
  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    _fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(_fadeController);

    _fadeController.forward();
    initPlatformState();
  }

  initPlatformState() async {
    fcmListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void iosPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void fcmListeners() {
    if (Platform.isIOS) iosPermission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        var data = message['data'] == null ? message : message['data'];
        // data is a json map
        print('on message $data');
        //_showItemDialog(data) for the new notification received
        _showItemDialog(data);
      },
      onResume: (Map<String, dynamic> message) async {
        var data = message['data'] == null ? message : message['data'];
        print('onResume $data');
        // TODO we should add code to route to target page
      },
      onLaunch: (Map<String, dynamic> message) async {
        var data = message['data'] == null ? message : message['data'];
        print('onLaunch $data');
        // TODO we should add code to route to target page
      },
    );
  }

  Widget _buildDialog(BuildContext context, String message) {
    return AlertDialog(
      content: Text('$message'),
      actions: <Widget>[
        FlatButton(
          child: Icon(Icons.check_circle),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(var data) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, data.toString()),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        // do nothing now
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var appLang = Provider.of<AppLanguage>(context);
    return Stack(
      children: <Widget>[
        Scaffold(
            // TODO: extract to shared instance
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).get('site.title')),
            ),
            drawer: Drawer(
                child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                  DrawerHeader(
                    child: Text('Drawer Header'),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    title: appLang.isEng() ? Text('中文') : Text('English'),
                    onTap: () {
                      appLang.changeLanguage(
                          appLang.isEng() ? Locale('zh') : Locale('en'));
                      Navigator.pop(context);
                    },
                  ),
                ])),
            body: StreamBuilder<List<Case>>(
              stream: AppBloc.instance.cases,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<Case> cases = snapshot.data;
                return Scaffold(
                  body: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        // in reverse order
                        return CaseCard(data: cases[cases.length - 1 - index]);
                      },
                      itemCount: cases?.length ?? 0,
                    ),
                    onRefresh: () async {
                      return Future.delayed(Duration(milliseconds: 1000));
                    },
                  ),
                  resizeToAvoidBottomPadding: false,
                );
              },
            )),
        AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) => _fadeAnimation.value > 0
              ? Container(
                  width: 3000.0,
                  height: 3000.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .buttonColor
                          .withAlpha((255 * _fadeAnimation.value).round())),
                )
              : SizedBox(),
        )
      ],
    );
  }
}
