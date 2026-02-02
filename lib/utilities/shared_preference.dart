import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static SharedPreferences? _pref;

  Future<SharedPreferences?> instance() async {
    if (_pref != null) return _pref;
    await SharedPreferences.getInstance()
        .then((onValue) {
          _pref = onValue;
        })
        .catchError((onError) {
          _pref = null;
        });
    return _pref;
  }

  static const String _userName = "userName";
  static const String _transporterName = "transporterName";
  static const String _phoneNumber = "phoneNumber";
  static const String _id = "id";
  static const String _accessToken = "accessToken";
  static const String _profileImage = "profileImage";
  static const String _userLogin = "userLogin";

  static Future<void> setUserName(String value) async {
    _pref?.setString(_userName, value);
  }

  static String getUserName() {
    return _pref?.getString(_userName) ?? "";
  }

  static Future<void> setTransporterName(String value) async {
    _pref?.setString(_transporterName, value);
  }

  static String getTransporterName() {
    return _pref?.getString(_transporterName) ?? "";
  }

  static Future<void> setPhoneNumber(String value) async {
    _pref?.setString(_phoneNumber, value);
  }

  static String getPhoneNumber() {
    return _pref?.getString(_phoneNumber) ?? "";
  }

  static Future<void> setId(int value) async {
    _pref?.setInt(_id, value);
  }

  static int getId() {
    return _pref?.getInt(_id) ?? 33;
  }

  static Future<void> setUserLogin(bool value) async {
    _pref?.setBool(_userLogin, value);
  }

  static bool getUserLogin() {
    return _pref?.getBool(_userLogin) ?? false;
  }

  static Future<void> setAccessToken(String value) async {
    _pref?.setString(_accessToken, value);
  }

  static String getAccessToken() {
    return _pref?.getString(_accessToken) ?? "";
  }

  static Future<void> setProfileImage(String value) async {
    _pref?.setString(_profileImage, value);
  }

  String getProfileImage() {
    return _pref?.getString(_profileImage) ?? "";
  }

  clearSharedPreference() {
    _pref?.clear();
  }
}
