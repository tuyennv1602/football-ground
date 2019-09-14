import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';

import 'app-bar-button.dart';

class AppBarWidget extends StatelessWidget {
  final appBarHeight;
  final Widget leftContent;
  final Widget centerContent;
  final Widget rightContent;
  final bool showBorder;
  final Color backgroundColor;

  AppBarWidget(
      {this.appBarHeight,
      this.leftContent,
      this.rightContent,
      @required this.centerContent,
      this.backgroundColor,
      this.showBorder = false});

  @override
  Widget build(BuildContext context) => Container(
        height: appBarHeight ?? 50,
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColor.PRIMARY,
            border: showBorder
                ? Border(
                    bottom: BorderSide(width: 0.5, color: AppColor.LINE_COLOR))
                : null),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            leftContent ?? AppBarButtonWidget(),
            Expanded(child: centerContent),
            rightContent ?? AppBarButtonWidget()
          ],
        ),
      );
}
