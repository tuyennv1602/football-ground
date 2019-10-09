import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:footballground/provider_setup.dart' as setupProvider;
import 'package:footballground/services/share_preferences.dart';
import 'package:footballground/ui/pages/login/login-page.dart';
import 'package:provider/provider.dart';
import 'http.dart';
import 'ui/pages/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() async {
  _firebaseMessaging.requestNotificationPermissions();
  var token = await SharePreferences().getToken();
  dio.interceptors
    ..add(CookieManager(CookieJar()))
    ..add(LogInterceptor(
        responseBody: true, requestBody: true, requestHeader: true));
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  return runApp(MyApp(token != null));
}

class MyApp extends StatelessWidget {
  final bool _isLogined;

  MyApp(this._isLogined);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: setupProvider.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Colors.transparent,
          fontFamily: 'regular',
        ),
        home: _isLogined ? HomePage() : LoginPage(),
      ),
    );
  }
}
