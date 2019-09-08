import 'package:flutter/material.dart';
import 'package:footballground/blocs/base-bloc.dart';
import 'package:footballground/blocs/forgot-password-bloc.dart';
import 'package:footballground/blocs/login-bloc.dart';
import 'package:footballground/blocs/noti-bloc.dart';
import 'package:footballground/blocs/register-bloc.dart';
import 'package:footballground/ui/pages/home-page.dart';
import 'package:footballground/ui/pages/login/forgot-password-page.dart';
import 'package:footballground/ui/pages/login/login-page.dart';
import 'package:footballground/ui/pages/login/register-page.dart';
import 'package:footballground/ui/pages/notify/noti-detail-page.dart';

import 'fade-in-route.dart';
import 'slide-left-route.dart';

class Routes {
  static routeToHomePage(BuildContext context) async {
    var page = HomePage();
    return await Navigator.of(context, rootNavigator: true)
        .pushAndRemoveUntil(FadeInRoute(widget: page), (Route<dynamic> route) => false);
  }

  static routeToLoginPage(BuildContext context) async {
    var page = BlocProvider<LoginBloc>(
      bloc: LoginBloc(),
      child: LoginPage(),
    );
    return await Navigator.of(context, rootNavigator: true)
        .pushAndRemoveUntil(FadeInRoute(widget: page), (Route<dynamic> route) => false);
  }

  static routeToForgotPasswordPage(BuildContext context) async {
    var page = BlocProvider<ForgotPasswordBloc>(
      bloc: ForgotPasswordBloc(),
      child: ForgotPasswordPage(),
    );
    return await Navigator.of(context).push(SlideLeftRoute(widget: page));
  }

  static routeToRegisterPage(BuildContext context) async {
    var page = BlocProvider<RegisterBloc>(
      bloc: RegisterBloc(),
      child: RegisterPage(),
    );
    return await Navigator.of(context).push(SlideLeftRoute(widget: page));
  }

  static routeToNotiDetailPage(BuildContext context) async {
    var page = BlocProvider<NotiBloc>(
      bloc: NotiBloc(),
      child: NotiDetailPage(),
    );
    return await Navigator.of(context, rootNavigator: true).push(SlideLeftRoute(widget: page));
  }
}
