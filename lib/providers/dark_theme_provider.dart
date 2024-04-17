

import 'package:apk1/services/dark_theme_prefs.dart';
import 'package:flutter/cupertino.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePerfs darkThemePerfs = DarkThemePerfs();
bool _darkTheme = false;
bool get getDarkTheme => _darkTheme;

set setDarkTheme(bool value){
  _darkTheme = value;
  darkThemePerfs.setDarkTheme(value);
  notifyListeners();
}
}