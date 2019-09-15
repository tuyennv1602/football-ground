import 'package:flutter/material.dart';
import 'package:footballground/blocs/ground-bloc.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/pages/base-page.dart';
import 'package:footballground/ui/widgets/app-bar-widget.dart';
import 'package:footballground/ui/widgets/border-background.dart';

// ignore: must_be_immutable
class GroundPage extends BasePage<GroundBloc> {
  @override
  Widget buildAppBar(BuildContext context) => AppBarWidget(
        centerContent: Text(
          'Quản lý sân bóng',
          textAlign: TextAlign.center,
          style: Styles.title(),
        ),
      );

  @override
  Widget buildMainContainer(BuildContext context) {
    return BorderBackground(
      child: Container(
        child: Text("ground"),
      ),
    );
  }

  @override
  void listenData(BuildContext context) {}

  @override
  bool get hasBottomBar => true;
}
