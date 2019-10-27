import 'package:flutter/material.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/utils/ui_helper.dart';

class EmptyWidget extends StatelessWidget {
  final String _message;

  EmptyWidget({@required String message}) : _message = message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/icn_empty.png',
          width: UIHelper.size50,
          height: UIHelper.size50,
          color: Colors.grey,
        ),
        UIHelper.verticalSpaceMedium,
        Text(
          _message,
          style: textStyleRegularTitle(color: Colors.grey),
        )
      ],
    );
  }
}