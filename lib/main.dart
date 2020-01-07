import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:footballground/provider_setup.dart' as setupProvider;
import 'package:footballground/router/navigation.dart';
import 'package:footballground/router/router.dart';
import 'package:footballground/services/local_storage.dart';
import 'package:footballground/util/local_timeago.dart';
import 'package:footballground/view/page/login/login_page.dart';
import 'package:provider/provider.dart';
import 'http.dart';
import 'view/page/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timeago/timeago.dart' as timeago;

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('vi', ViMessage());
  _firebaseMessaging.requestNotificationPermissions();
  var token = await LocalStorage().getToken();
  dio.interceptors
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
        navigatorKey: Navigation().navigatorKey,
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          canvasColor: Colors.transparent,
          fontFamily: 'regular',
        ),
        home: _isLogined ? HomePage() : LoginPage(),
      ),
    );
  }
}
