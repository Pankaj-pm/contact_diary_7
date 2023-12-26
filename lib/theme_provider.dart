import 'package:contact_diary_7/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = prefs.getBool("theme")??false;


  void changeTheme() async {
    isDark = !isDark;
    prefs.setBool("theme", isDark);
    notifyListeners();
  }
  void getTheme() {
    bool? val=prefs.getBool("theme");
    print("Theme ==> $val");
  }
}
