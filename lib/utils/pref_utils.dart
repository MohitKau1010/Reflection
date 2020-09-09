import 'dart:convert';

import 'package:reflection/models/QuesListData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {

  ///PrefUtils.remove(PrefUtils.KEY_TOKEN);
  ///
  /// Example
  ///
  static const String KEY_TOKEN = "KEY_LOGIN_TOKEN";
  static const String KEY_EMAIL = "KEY_SEND_EMAIL";

  ///handle question scroll
  static const String KEY_ANSWER_LIST = "KEY_ANSWER_LIST";
  //static const String KEY_FIVE = "KEY_FIVE";

  static setListData(String key,List<Question> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }
  static readListData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }
  static clearListData(String key) async{
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
  }

  static setBoolValue(String key,bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key,value);
  }
  static getBoolValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool(key);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static addString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? null;
  }

  static addBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    return prefs.getBool(key) ?? false;
  }
}
