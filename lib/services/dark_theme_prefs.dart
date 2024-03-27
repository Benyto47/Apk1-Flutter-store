import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePerfs{
  static const THEME_STAUS = "THEMESTATUS";
  setDarkTheme(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STAUS, value);
  }

  Future <bool> getTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STAUS) ?? false;
  }
}