import 'package:flutter/material.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/view/widgets/app_bar_widget.dart';
import 'package:footballground/view/widgets/border_background.dart';

class AnalyticPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnalyticState();
}

class _AnalyticState extends State<AnalyticPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            centerContent: Text(
              "Thống kê",
              textAlign: TextAlign.center,
              style: textStyleTitle(),
            ),
          ),
          Expanded(child: BorderBackground(child: Text('ok')))
        ],
      ),
    );
  }
}
