import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  const SharedPrefUtils._();

  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences (Call this in main() before runApp)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save a String value
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }
  /// Save a List String value
  static Future<void> setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  /// Get a String value
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  //
  static getStringList(String key){
    return _prefs?.getStringList(key);
  }

  /// Clear all SharedPreferences
  static Future<void> clearAll() async {
    await _prefs?.clear();
    await _prefs?.remove('token');
    await _prefs?.remove('data');
  }
}