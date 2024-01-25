import 'package:flutter/material.dart';
import 'package:music_player/themes/dark_theme.dart';
import 'package:music_player/themes/light_theme.dart';

class ThemeProvider extends ChangeNotifier {

  //initiallize light theme
  ThemeData _themeData = lightTheme;

  //getter theme
  ThemeData get themeData => _themeData;

  //is it dark theme?
  bool get isDarkTheme => _themeData == darkTheme;

  //setter theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

  // Update the UI
    notifyListeners();
  }

  //toggle theme method
  void toggleTheme () {
    if(_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }

  }

}