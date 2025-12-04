import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {

  static SharedPreferences? prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs);
  }

  static saveData(String key, String value) async {
    await prefs?.setString(key, value);
  }

  static String getData(String key){
    return prefs?.getString(key) ?? '';
  }

}