
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  bool isDark=false;

  void changeTheme(){
    isDark=!isDark;
    notifyListeners();
  }

}