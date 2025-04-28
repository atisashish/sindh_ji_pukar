import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final Future<SharedPreferences> prefsData =
      SharedPreferences.getInstance();

  static Future<void> setLogin(bool isLogin) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setBool("isLogin", isLogin);
  }

  static Future<bool> getLogin() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getBool("isLogin") ?? false;
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getString("token") ?? '';
  }

  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setString("token", token);
  }

  static prefsDataClear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
