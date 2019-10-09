import 'dart:convert';

import 'package:footballground/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferences {
  static const String ACCESS_TOKEN = 'token';
  static const String TEAM = 'team';

  Future<bool> setToken(Token token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(ACCESS_TOKEN, jsonEncode(token));
  }

  Future<Token> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenData = prefs.getString(ACCESS_TOKEN);
    if (tokenData == null) return null;
    return Token.fromJson(jsonDecode(tokenData));
  }

  Future<bool> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(ACCESS_TOKEN);
  }

  Future<bool> clearLastTeam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(TEAM);
  }
}
