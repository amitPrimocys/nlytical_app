import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

//import your model class
class SharedPrefs {
  static SharedPreferences? _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  //for set value
  static Future<bool> setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs!.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs!.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);

  // Save SignUpPojo instance to preferences
  //use your model class,here my model class Name is SignUpPojo

  // Save a model instance to preferences
  static Future<bool> setModel<T>(String key, T model) async {
    assert(_prefs != null, 'Call initialize() before using preferences.');
    final String jsonString = jsonEncode(model);
    return await _prefs!.setString(key, jsonString);
  }

  // Get a model instance from preferences
  static T? getModel<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    assert(_prefs != null, 'Call initialize() before using preferences.');
    final String? jsonString = _prefs!.getString(key);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return fromJson(jsonMap);
    }
    return null;
  }

  //for get data

  // Get SignUpPojo instance from preferences

  static bool getBool(String key) => _prefs!.getBool(key) ?? true;

  static double getDouble(String key) => _prefs!.getDouble(key) ?? 0.0;

  static int getInt(String key) => _prefs!.getInt(key) ?? 0;

  static String getString(String key) => _prefs!.getString(key) ?? "";

  //for delete data
  static Future<bool> remove(String key) async => await _prefs!.remove(key);

  static Future<bool> clear() async => await _prefs!.clear();
}
