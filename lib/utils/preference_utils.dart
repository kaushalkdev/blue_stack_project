import 'package:bluestack_test_app/index.dart';

class PreferenceUtils {
  SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //setters
  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

  //getters
  bool getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  String getString(String key) {
    return _sharedPreferences.getString(key);
  }
}

var preferenceUtils = PreferenceUtils();
