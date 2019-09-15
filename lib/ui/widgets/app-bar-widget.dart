import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';

import 'app-bar-button.dart';

const double _kAppbarHeight = 48;

class AppBarWidget extends StatelessWidget {
  final Widget leftContent;
  final Widget centerContent;
  final Widget rightContent;
  final bool showBorder;
  final Color backgroundColor;

  AppBarWidget(
      {Key key,
      this.leftContent,
      this.rightContent,
      @required this.centerContent,
      this.backgroundColor,
      this.showBorder = false})
      : assert(centerContent != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: _kAppbarHeight,
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
