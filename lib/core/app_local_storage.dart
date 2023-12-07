import 'package:shared_preferences/shared_preferences.dart';

class AppLocal {
  static String imageKey = 'Image_Key';
  static String nameKey = 'Name_key';
  static String isUpload = 'isUpload';

  static cacheData(String key, String data) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  static Future<String> getCached(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  //Bool chache
  static cacheBool(String key, bool data) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, data);
  }

  static Future<bool> getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
