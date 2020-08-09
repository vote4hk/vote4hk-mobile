import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

User currentUser;

abstract class UserService {
  User _stateCurrentUser;
  User get currentUser => _stateCurrentUser;

  void notifcationListener(Function foreground, Function backgroundOrInactive);
}

class FirebaseUserService extends UserService{
  static final UserService _userService = FirebaseUserService._internal();
  SharedPreferences sharedPreferences;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  factory FirebaseUserService() {
    return FirebaseUserService._userService;
  }
  // constructor
  FirebaseUserService._internal() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      String _userID = sharedPreferences.getString('userID');
      _checkIsSignedIn(_userID);
    });
  }

  //Checks if the user has signed in
  Future<void> _checkIsSignedIn(String userID) async {
    String fbUserID = userID;
    AuthResult _res = await _auth.signInAnonymously();
    // regist for fcm
    _firebaseMessaging.getToken().then((token) {
      // for easy debug to get the token in console
      print('FCM: ${token}');
      // get token storage in location storage;
      String oldToken = sharedPreferences.get('fcm');
      if (fbUserID == null) {
        fbUserID = _res.user.uid;
        sharedPreferences.setString('userID', fbUserID);
      }
      _stateCurrentUser = new User(fbUserID, token);
      if (oldToken != token || userID == null) {
        // override existing token
        sharedPreferences.setString('fcm', token);
        Firestore.instance
            .collection('user')
            .document(_stateCurrentUser.id)
            .setData(_stateCurrentUser.toMap());
      }
    });
  }

  void _iosPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void notifcationListener(Function foreground, Function backgroundOrInactive) {
    if (Platform.isIOS) _iosPermission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        var data = message['data'] == null ? message : message['data'];
        print('on message 2 $data');
        // data is a json map
        //_showItemDialog(data) for the new notification received
        foreground(data);
      },
      onResume: (Map<String, dynamic> message) async {
        var data = message['data'] == null ? message : message['data'];
        print('onResume $data');
        backgroundOrInactive(data);
      },
      onLaunch: (Map<String, dynamic> message) async {
        var data = message['data'] == null ? message : message['data'];
        print('onLaunch $data');
        backgroundOrInactive(data);
      },
    );
  }
}
