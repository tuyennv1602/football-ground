import 'package:flutter/material.dart';

import 'package:footballground/ui/pages/home_page.dart';
import 'package:footballground/ui/pages/login/forgot-password-page.dart';
import 'package:footballground/ui/pages/login/login-page.dart';
import 'package:footballground/ui/pages/login/register-page.dart';

import 'fade-in-route.dart';
import 'slide-left-route.dart';

class Routes {
  static Future<dynamic> routeToHome(BuildContext context) async {
    var page = HomePage();
    return await Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        FadeInRoute(widget: page), (Route<dynamic> route) => false);
  }

  static Future<dynamic> routeToLogin(BuildContext context) async {
    return await Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        FadeInRoute(widget: LoginPage()), (Route<dynamic> route) => false);
  }

  static Future<dynamic> routeToForgotPassword(BuildContext context) async {
    return await Navigator.of(context)
        .push(SlideLeftRoute(widget: ForgotPasswordPage()));
  }

  static Future<dynamic> routeToRegister(BuildContext context) async {
    return await Navigator.of(context)
        .push(SlideLeftRoute(widget: RegisterPage()));
  }
}
