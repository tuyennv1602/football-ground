import 'package:flutter/material.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/view/ui_helper.dart';

class LineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.7,
      indent: UIHelper.size(10),
      endIndent: UIHelper.size(10),
      color: LINE_COLOR,
    );
  }
}
