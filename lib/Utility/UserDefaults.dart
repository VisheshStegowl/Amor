import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
final key_tutorial = "key_tutorial";
// ignore: non_constant_identifier_names
final key_remember = "key_remember";
// ignore: non_constant_identifier_names
final key_email = "key_email";
// ignore: non_constant_identifier_names
final key_password = "key_password";
// ignore: non_constant_identifier_names
final key_accesstoken = "key_accesstoken";
// ignore: non_constant_identifier_names
final key_userdata = "key_userdata";

// ignore: non_constant_identifier_names
final key_userID = "key_userID";

class UserDefaults {
  UserDefaults._privateConstructor();
  static final UserDefaults _instance = UserDefaults._privateConstructor();
  static UserDefaults get instance => _instance;

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) == null ? null : json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

   Future<bool> get isTutorial async {
    SharedPreferences newUserDefault = await SharedPreferences.getInstance();
     return(newUserDefault.getBool(key_tutorial));
  }

  void setString(String key, String value) async {
    SharedPreferences newUserDefault = await SharedPreferences.getInstance();
    newUserDefault.setString(key, value);
  }

  Future<String> getStrings(String key) async  {
    SharedPreferences newUserDefault = await SharedPreferences.getInstance();
    return newUserDefault.getString(key);
  }

  void setBool(String key, bool value) async {
    SharedPreferences newUserDefault = await SharedPreferences.getInstance();
    newUserDefault.setBool(key, value);
  }

  Future<bool> getBool(String key) async  {
    SharedPreferences newUserDefault = await SharedPreferences.getInstance();
    return newUserDefault.getBool(key);
  }

  // void _removeAll() async {
  //   SharedPreferences newUserDefault = await SharedPreferences.getInstance();
  // }


}