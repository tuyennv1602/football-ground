import 'package:flutter/material.dart';
import 'package:footballground/blocs/noti-bloc.dart';
import 'package:footballground/ui/widgets/app-bar-widget.dart';

import '../base-page.dart';

class NotiDetailPage extends BasePage<NotiBloc> {
  @override
  AppBarWidget buildAppBar(BuildContext context) {
    return AppBarWidget(
      centerContent: Text("data"),
    );
  }

  @override
  Widget buildLoading(BuildContext context) {
    return null;
  }

  @override
  Widget buildMainContainer(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Text("back"),
      ),
    );
  }

  @override
  void listenData(BuildContext context) {}
}
