import 'dart:convert';

import 'package:footballground/model/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String ACCESS_TOKEN = 'token';
  static const String TEAM = 'team';

  Future<bool> setToken(Token token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(ACCESS_TOKEN, jsonEncode(token));
  }

  Future<Token> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenData = prefs.getString(ACCESS_TOKEN);
//    var tokenData = 'e4a6332f-a7ff-4700-aa42-43c08342ac0a';
    if (tokenData == null) return null;
    return Token.fromJson(jsonDecode(tokenData));
  }

  Future<bool> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(ACCESS_TOKEN);
  }
}
