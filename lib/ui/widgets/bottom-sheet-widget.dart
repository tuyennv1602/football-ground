import 'package:flutter/material.dart';
import 'package:footballground/utils/device-util.dart';

import 'button-widget.dart';

typedef void OnClickOption(int index);

class BottomSheetWidget extends StatefulWidget {
  final List<String> options;
  final OnClickOption onClickOption;

  BottomSheetWidget({@required this.options, this.onClickOption});

  @override
  State<StatefulWidget> createState() => BootomSheetState();
}

class BootomSheetState extends State<BottomSheetWidget> {
  List<Widget> children = [];
  static const double BUTTON_HEIGHT = 50;

  @override
  Widget build(BuildContext context) {
    int length = widget.options.length;
    widget.options.asMap().forEach((index, value) {
      if (index == 0) {
        children.add(SizedBox(
          height: BUTTON_HEIGHT,
          child: Center(
            child: Text(
              value,
              style: TextStyle(color: Colors.black, fontFamily: 'semi-bold', fontSize: 18),
            ),
          ),
        ));
      } else if (index == length - 1) {
        children.add(ButtonWidget(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          height: BUTTON_HEIGHT,
          child: Text(
            value,
            style: TextStyle(
                fontFamily: 'semi-bold', fontSize: 16, letterSpacing: 0.1, color: Colors.red),
          ),
          onTap: () => Navigator.of(context).pop(),
        ));
      } else {
        children.add(ButtonWidget(
          height: BUTTON_HEIGHT,
          child: Text(
            value,
            style: TextStyle(
                fontFamily: 'regular', fontSize: 16, letterSpacing: 0.1, color: Colors.black87),
          ),
          onTap: () => widget.onClickOption(index),
        ));
      }
      children.add(Container(
        height: 1,
        color: index != length - 1 ? Colors.grey[200] : Colors.transparent,
      ));
    });
    return Container(
      height: ((length * BUTTON_HEIGHT) + length).toDouble(),
      margin: EdgeInsets.only(left: 15, right: 15, bottom: DeviceUtil.getPaddingBottom(context)),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          children: this.children,
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
    );
  }
}
