import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:footballground/utils/ui_helper.dart';

class GroundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GroundState();
  }
}

class GroundState extends State<GroundPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UIHelper().init(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            centerContent: Text(
              'Sân bóng',
              textAlign: TextAlign.center,
              style: textStyleTitle(),
            ),
          ),
          Expanded(child: BorderBackground(child: Text('data')))
        ],
      ),
    );
  }
}
