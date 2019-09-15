import 'package:flutter/material.dart';

class BorderBackground extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color backgroundColor;

  BorderBackground(
      {Key key, @required this.child, this.radius = 20, this.backgroundColor})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(this.radius),
          topLeft: Radius.circular(this.radius)),
      child: Container(
        color: this.backgroundColor ?? Colors.white,
        child: this.child,
      ),
    );
  }
}
