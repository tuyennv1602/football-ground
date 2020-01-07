import 'package:flutter/material.dart';
import 'package:footballground/model/address_info.dart';
import 'package:footballground/model/create_ground_param.dart';
import 'package:footballground/router/paths.dart';
import 'package:footballground/view/page/ground/create_field_page.dart';
import 'package:footballground/view/page/ground/create_ground_page.dart';
import 'package:footballground/view/page/ground/location_page.dart';
import 'package:footballground/view/page/ground/region_page.dart';
import 'package:footballground/view/page/home_page.dart';
import 'package:footballground/view/page/login/forgot_password_page.dart';
import 'package:footballground/view/page/login/login_page.dart';
import 'package:footballground/view/page/login/register_page.dart';
import 'fade_in_router.dart';
import 'slide_left_router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HOME:
      return FadeInRoute(widget: HomePage());
    case LOGIN:
      return FadeInRoute(widget: LoginPage());
    case FORGOT_PASSWORD:
      return SlideLeftRoute(widget: ForgotPasswordPage());
    case REGISTER:
      return SlideLeftRoute(widget: RegisterPage());
    case LOCATION:
      return SlideLeftRoute(widget: LocationPage());
    case REGION:
      var addressInfos = settings.arguments as List<AddressInfo>;
      return SlideLeftRoute(widget: RegionPage(addressInfos: addressInfos));
    case CREATE_GROUND:
      var params = settings.arguments as CreateGroundParam;
      return SlideLeftRoute(widget: CreateGroundPage(params: params));
    case CREATE_FIELD:
      var number = settings.arguments as int;
      return SlideLeftRoute(widget: CreateFieldPage(number: number));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
