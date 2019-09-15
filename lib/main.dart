import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'blocs/app-bloc.dart';
import 'blocs/base-bloc.dart';
import 'blocs/login-bloc.dart';
import 'data/app-preference.dart';
import 'http.dart';
import 'ui/pages/home-page.dart';
import 'ui/pages/login/login-page.dart'; // make dio as global top-level variable
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
  await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  _firebaseMessaging.requestNotificationPermissions();
  var token = await AppPreference().getToken();
  dio.interceptors
    ..add(CookieManager(CookieJar()))
    ..add(LogInterceptor(responseBody: true));
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  return runApp(BlocProvider<AppBloc>(
    bloc: AppBloc(),
    child: MyApp(token != null),
  ));
}

class MyApp extends StatelessWidget {
  final bool _isLogined;

  MyApp(this._isLogined);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Colors.transparent,
          fontFamily: 'regular',
        ),
        home: _isLogined
            ? HomePage()
            : BlocProvider<LoginBloc>(
                bloc: LoginBloc(),
                child: LoginPage(),
              ));
  }
}
