import 'package:flutter/material.dart';
import 'package:footballground/models/address_info.dart';
import 'package:footballground/ui/pages/ground/create_field_page.dart';
import 'package:footballground/ui/pages/ground/create_ground_page.dart';
import 'package:footballground/ui/pages/ground/location_page.dart';
import 'package:footballground/ui/pages/ground/region_page.dart';
import 'package:footballground/ui/pages/home_page.dart';
import 'package:footballground/ui/pages/login/forgot_password_page.dart';
import 'package:footballground/ui/pages/login/login_page.dart';
import 'package:footballground/ui/pages/login/register_page.dart';
import 'package:footballground/ui/routes/slide-right-route.dart';
import 'package:geocoder/geocoder.dart';
import 'fade-in-route.dart';
import 'slide-left-route.dart';

class Routes {
  static Future<dynamic> routeToHome(BuildContext context) async {
    var page = HomePage();
    return await Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        FadeInRoute(widget: page), (Route<dynamic> route) => false);
  }

  static Future<dynamic> routeToHome2(BuildContext context) async {
    var page = HomePage();
    return await Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        SlideRightRoute(widget: page), (Route<dynamic> route) => false);
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

  static Future<dynamic> routeToLocation(BuildContext context) async {
    return await Navigator.of(context, rootNavigator: true)
        .push(SlideLeftRoute(widget: LocationPage()));
  }

  static Future<dynamic> routeToRegion(
      BuildContext context, List<AddressInfo> addressInfos) async {
    return await Navigator.of(context).push(SlideLeftRoute(
        widget: RegionPage(
      addressInfos: addressInfos,
    )));
  }

  static Future<dynamic> routeToCreateGround(
      BuildContext context, Address address, AddressInfo addressInfo) async {
    return await Navigator.of(context).push(SlideLeftRoute(
        widget: CreateGroundPage(
      address: address,
      addressInfo: addressInfo,
    )));
  }

  static Future<dynamic> routeToCreateField(
      BuildContext context, bool isPopToRoot, int number) async {
    return await Navigator.of(context, rootNavigator: true).push(SlideLeftRoute(
        widget: CreateFieldPage(
      isPopToRoot: isPopToRoot,
      number: number,
    )));
  }
}
