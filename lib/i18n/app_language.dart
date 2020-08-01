import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocale => _appLocale ?? Locale("en");

  bool isEng() {
    return appLocale.languageCode == 'en';
  }

  static bool isContextEng(BuildContext context) {
    var appLang = Provider.of<AppLanguage>(context);
    return appLang.isEng();
  }

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }


  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("zh")) {
      _appLocale = Locale("zh");
      await prefs.setString('language_code', 'zh');      
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');      
    }
    notifyListeners();
  }
}