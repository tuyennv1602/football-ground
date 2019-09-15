import 'package:flutter/widgets.dart';

class SizeConfig {

  static final SizeConfig _instance = SizeConfig.internal();
  factory SizeConfig() => _instance;
  SizeConfig.internal();

  static MediaQueryData _mediaQueryData;

  static double paddingTop;
  static double paddingBottom;

  static double screenWidth;
  static double screenHeight;

  // split screen to 100 block

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    paddingTop = _mediaQueryData.padding.top;
    paddingBottom = _mediaQueryData.padding.bottom;
  }

  static double size(double size) {
    const double baseWidth = 375;
    double percent = screenWidth / baseWidth;
    if (percent < 1) {
      return size * percent;
    }
    return size;
  }
}
