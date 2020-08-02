import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String _id;
  String _fcmToken;

  User(this._id, this._fcmToken) {

  }

  String get id => _id;
  String get fcmToken => _fcmToken;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    if (_fcmToken != '') {
      map['fcmToken'] = _fcmToken;
    }
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    try {
      if (map['fcmToken'] == null) {
        this._fcmToken = '';
      } else {
        this._fcmToken = map['fcmToken'];
      }
    } catch (exception) {
      this._fcmToken = '';
    }
  }
}
