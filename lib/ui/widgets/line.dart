import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';

class LineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 10,
      endIndent: 10,
      color: AppColor.LINE_COLOR,
    );
  }

}