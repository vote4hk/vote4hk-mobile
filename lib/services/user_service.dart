import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

User currentUser;
UserService userService;

class UserService {
  SharedPreferences _sharedPreferences;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // constructor
  UserService() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
      String _userID = _sharedPreferences.getString('userID');
      checkIsSignedIn(_userID);
    });
  }

  //Checks if the user has signed in
  Future<void> checkIsSignedIn(String _userID) async {
    String userID = _userID;
    AuthResult _res = await _auth.signInAnonymously();
    _firebaseMessaging.getToken().then((token) {
      print(token);
      // get token storage in location storage;
      String oldToken = _sharedPreferences.get('fcm');
      if (userID == null) {
        userID = _res.user.uid;
        _sharedPreferences.setString('userID', userID);
      }
      currentUser = new User(userID, token);
      if (oldToken != token || _userID == null) {
        // override existing token
        _sharedPreferences.setString('fcm', token);
        Firestore.instance
            .collection('user')
            .document(currentUser.id)
            .setData(currentUser.toMap());
      }
    });
  }
}
