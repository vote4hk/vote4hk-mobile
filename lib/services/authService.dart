import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';


import '../main.dart';

bool blIsSignedIn = false;

class AuthService {
  // constructor
  AuthService() {
    String _userID = sharedPreferences.get("userID"); 
    if (!kReleaseMode) {
      _userID = "1586890205088";
    }
    checkIsSignedIn(_userID).then((_blIsSignedIn) {
      //redirect to appropriate screen
      mainNavigationPage();
    });
  }

  //Checks if the user has signed in
  Future<bool> checkIsSignedIn(String _userID) async {
    DateTime now = DateTime.now();
    if(_userID == null) {
      Random rng = new Random();
      return sharedPreferences.setString('userID', now.millisecondsSinceEpoch.toString()).then((value) {
          blIsSignedIn = value;
          return value;});
    } else {
      blIsSignedIn = true;
      return blIsSignedIn;
    }
    }
  }