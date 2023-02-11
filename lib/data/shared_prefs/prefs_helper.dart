import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper<T> {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Future<void> setString(String key, String value) async {
    final p = await prefs;
    p.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    final p = await prefs;
    p.setBool(key, value);
  }

  Future<void> setInt(String key, int value) async {
    final p = await prefs;
    p.setInt(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    final p = await prefs;
    p.setDouble(key, value);
  }

  Future<String> getString(String key) async {
    final p = await prefs;
    if (key == 'locale') {
      return p.getString(key) ?? "ru";
    } else {
      return p.getString(key) ?? "" ;
    }
  }

  Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? false;
  }

  Future<int> getInt(String key) async {
    final p = await prefs;
    return p.getInt(key) ?? 0;
  }

  Future<double> getDouble(String key) async {
    final p = await prefs;
    return p.getDouble(key) ?? 0.0;
  }

  Future<R?> getClass<R>(String key, Function(T) converter) async {
    final p = await prefs;
    final value = p.getString(key) ?? '';
    try {
      return converter(value as T);
    } catch (e) {
      try {
        final json = jsonDecode(value);
        return converter(json as T);
      } catch (e) {
        return null;
      }
    }
  }

  Future clear() async {
    final p = await prefs;
    p.clear();
  }
}