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
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0'
      ];
  }

  static setSavedArticlesPref(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedArticles', value);
  }

  static Future<List<String>> getSavedArticlesPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('savedArticles') != null)
      return prefs.getStringList('savedArticles');
    else
      return [];
  }
}
