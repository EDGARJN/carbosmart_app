import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static late SharedPreferences _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();
  static const tokKey = "38usv@%!yuwkei2";
  static const userKey = "BnS1@qEtZ&B*";
  static const notKey = "yweiusjjy2389ng7!@#!";

  // Token Server
  static setRecommendation(token) async =>
      await _prefs.setString(tokKey, token); // store token
  static getRecommendation() {
    var token = _prefs.getString(tokKey);
    return token;
  }

// swithc
 static switchStatus(status) async =>
      await _prefs.setString(notKey, status); // store token
  static getSwitchStatus() {
    var token = _prefs.getString(notKey);
    return token;
  }

// user Important Infos
  static Future userInfo(List data) async {
    await _prefs.setStringList(userKey,
        <String>[data[0], data[1], data[2], data[3], data[4], data[5]]);
    print(data);
  } // serve user Infos

  static List<String>? getUSerInfo() {
    var user = _prefs.getStringList(userKey);
    return user;
  }


  static logOUT() async {
    await _prefs.remove(tokKey);
  }
}
