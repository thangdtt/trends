import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static setIsDarkModePref(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  static Future<bool> getIsDarkModePref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDarkMode') != null)
      return prefs.getBool('isDarkMode');
    else
      return false;
  }

  static setIsFastReadModePref(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFastReadMode', value);
  }

  static Future<bool> getIsFastReadModePref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isFastReadMode') != null)
      return prefs.getBool('isFastReadMode');
    else
      return false;
  }

  static setPageFontSizeFactorPref(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('pageFontSizeFactor', value);
  }

  static Future<double> getPageFontSizeFactorPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble('pageFontSizeFactor') != null)
      return prefs.getDouble('pageFontSizeFactor');
    else
      return 1.0;
  }

  static setPageBackgroundColorPref(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('pageBackgroundColor', value);
  }

  static Future<int> getPageBackgroundColorPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('pageBackgroundColor') != null)
      return prefs.getInt('pageBackgroundColor');
    else
      return 0;
  }

  static setTextColorPref(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('textColor', value);
  }

  static Future<int> getTextColorPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('textColor') != null)
      return prefs.getInt('textColor');
    else
      return 0;
  }

  static setFilterPref(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('filterList', value);
  }

  static Future<List<String>> getFilterPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('filterList') != null)
      return prefs.getStringList('filterList');
    else
      return [
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
        '1',
      ];
  }

  static setHistoryPref(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('history', value);
  }

  static Future<List<String>> getHistoryPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('history') != null)
      return prefs.getStringList('history');
    else
      return [];
  }

  // static setFptApiPref(String value) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('fpt-api', value);
  // }

  // static Future<String> getFptApiPref() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('fpt-api') != null)
  //     return prefs.getString('fpt-api');
  //   else
  //     return "JJw44LERRempB76I1BNddOyYhzEhCyK0";
  // }
}
