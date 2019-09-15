import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';

class BorderFrameWidget extends StatelessWidget {
  final EdgeInsets margin;
  final Widget child;
  final Color backgroundColor;
  final double border;

  BorderFrameWidget(
      {Key key,
      this.margin,
      @required this.child,
      this.backgroundColor,
      this.border})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        margin: this.margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(border ?? 5),
            color: backgroundColor ?? AppColor.GREY_BACKGROUND),
        child: this.child,
      );
}
