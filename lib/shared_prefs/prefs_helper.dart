import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper<T> {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Future<void> set(String key, T value) async {
    final p = await prefs;
    if (T is bool) {
      p.setBool(key, value as bool);
    } else if (T is int) {
      p.setInt(key, value as int);
    } else if (T is double) {
      p.setDouble(key, value as double);
    } else if (T is String) {
      p.setString(key, value as String);
    } else {
      throw UnimplementedError();
    }
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


  // Future<T> get(String key) async {
  //   final p = await prefs;
  //   if (T is bool) {
  //     return (p.getBool(key) ?? false) as T;
  //   } else if (T is int) {
  //     return (p.getInt(key) ?? 0) as T;
  //   } else if (T is double) {
  //     return (p.getDouble(key) ?? 0) as T;
  //   } else if (T is String) {
  //     if (key == 'locale') {
  //       return (p.getString(key) ?? "ru") as T;
  //     } else {
  //       return (p.getString(key) ?? "") as T;
  //     }
  //   } else {
  //     log("Prefs error for key $key");
  //     throw UnimplementedError();
  //   }
  // }

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