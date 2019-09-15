import 'package:flutter/material.dart';
import 'package:footballground/utils/size-config.dart';

import 'fonts.dart';

class Styles {
  static TextStyle title({Color color}) => TextStyle(
      fontSize: SizeConfig.size(18),
      fontFamily: Fonts.SEMI_BOLD,
      color: color ?? Colors.white,
      letterSpacing: 0.1);

  static TextStyle appName({Color color}) => TextStyle(
      fontSize: SizeConfig.size(25),
      fontFamily: Fonts.BOLD,
      color: color ?? Colors.white,
      letterSpacing: 0.1);

  static TextStyle button({double size, Color color}) => TextStyle(
      fontSize: SizeConfig.size(size ?? 16),
      fontFamily: Fonts.SEMI_BOLD,
      color: color ?? Colors.white,
      letterSpacing: 0.1);

  static TextStyle italic({double size, Color color}) => TextStyle(
      fontSize: SizeConfig.size(size ?? 14),
      fontFamily: Fonts.ITALIC,
      color: color ?? Colors.black87,
      letterSpacing: 0.1);

  static TextStyle regular({double size, Color color}) => TextStyle(
      fontSize: SizeConfig.size(size ?? 14),
      fontFamily: Fonts.REGULAR,
      color: color ?? Colors.black87,
      letterSpacing: 0.1);

  static TextStyle semiBold({double size, Color color}) => TextStyle(
      fontSize: SizeConfig.size(size ?? 16),
      fontFamily: Fonts.SEMI_BOLD,
      color: color ?? Colors.black87,
      letterSpacing: 0.1);

  static TextStyle bold({double size, Color color}) => TextStyle(
      fontSize: SizeConfig.size(size ?? 18),
      fontFamily: Fonts.BOLD,
      color: color ?? Colors.black87,
      letterSpacing: 0.1);

  static TextStyle textInput({double size, Color color}) => TextStyle(
      fontSize: SizeConfig.size(size ?? 16),
      fontFamily: Fonts.REGULAR,
      color: color ?? Colors.black87,
      letterSpacing: 0.1);
}
