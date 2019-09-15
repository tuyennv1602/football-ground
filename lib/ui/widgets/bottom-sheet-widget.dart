import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/fonts.dart';
import 'package:footballground/ui/widgets/border-background.dart';

import 'button-widget.dart';

typedef void OnClickOption(int index);

// ignore: must_be_immutable
class BottomSheetWidget extends StatelessWidget {
  final List<String> options;
  final OnClickOption onClickOption;
  List<Widget> children = [];
  static const double BUTTON_HEIGHT = 50;

  BottomSheetWidget({Key key, @required this.options, this.onClickOption})
      : assert(options != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    int length = options.length;
    options.asMap().forEach((index, value) {
      if (index == 0) {
        children.add(SizedBox(
          height: BUTTON_HEIGHT,
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                  color: AppColor.PRIMARY,
                  fontFamily: Fonts.SEMI_BOLD,
                  fontSize: 16),
            ),
          ),
        ));
      } else if (index == length - 1) {
        children.add(ButtonWidget(
          height: BUTTON_HEIGHT,
          child: Text(
            value,
            style: TextStyle(
                fontFamily: Fonts.SEMI_BOLD,
                fontSize: 16,
                letterSpacing: 0.1,
                color: Colors.red),
          ),
          onTap: () => Navigator.of(context).pop(),
        ));
      } else {
        children.add(ButtonWidget(
          height: BUTTON_HEIGHT,
          child: Text(
            value,
            style: TextStyle(
                fontFamily: Fonts.REGULAR,
                fontSize: 16,
                letterSpacing: 0.1,
                color: Colors.black87),
          ),
          onTap: () => onClickOption(index),
        ));
      }
      children.add(Container(
        height: 1,
        color: index != length - 1 ? Colors.grey[200] : Colors.transparent,
      ));
    });
    return Container(
      color: Colors.transparent,
      child: Wrap(
        children: <Widget>[
          BorderBackground(
            child: Column(
              children: this.children,
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          )
        ],
      ),
    );
  }
}
