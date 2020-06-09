import 'package:intl/intl.dart';

class Constants {
  static final dateFormat = DateFormat('yyyyMMdd', "en_US");

  // This url contains data that is related with our story or keyword( when you use explore to search)
  // {0}: LANGUAGE (you can get list format of language to google_trend_language.txt in root of project)
  // {1} : CATEGORY  (The format of list of geography  is in GOOGLE_TREND_CATEGORY_URL response)
  // {2}: GEOGRAPHY (The format of list of geography  is in GOOGLE_TREND_GEOGRAPHY_URL response)
  static const String GOOGLE_TREND_URL =
      "https://trends.google.com.vn/trends/api/realtimetrends?hl=%s&tz=-420&cat=%s&fi=0&fs=0&geo=%s&ri=300&rs=15&sort=0";

  //static const String USER_AGENT = "Mozilla/5.0";

  // This url contains data of each stories but not detail
  // {0}: LANGUAGE (you can get list format of language to google_trend_language.txt in root of project)
  // {1}: ID of story. You can add more than one ID and each is separated by "," (id=xx...,id=yyf...)
  static const String TRENDING_SUMMARY_URL =
      "https://trends.google.com.vn/trends/api/stories/summary?hl=%s&tz=-420&cat=%s&geo=VN&%s";
}
