import 'package:flutter/material.dart';
import 'package:footballground/blocs/noti-bloc.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/app-bar-widget.dart';

import '../base-page.dart';

// ignore: must_be_immutable
class NotiPage extends BasePage<NotiBloc> {
  @override
  Widget buildAppBar(BuildContext context) {
    return AppBarWidget(
      centerContent: Text(
        "Thông báo",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  @override
  Widget buildMainContainer(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<bool>(
          stream: pageBloc.notiStream,
          builder: (c, snap) => Text((snap.hasData && snap.data) ? "Changed" : "Init"),
        ),
        InkWell(
          onTap: () => pageBloc.changeNotiFunc(true),
          child: Text("Change"),
        ),
        InkWell(
          onTap: () => Routes.routeToNotiDetailPage(context),
          child: Text("next page"),
        )
      ],
    );
  }

  @override
  void listenData(BuildContext context) {
    pageBloc.notiStream.listen((onData) {
      print(onData);
    });
  }

  @override
  bool get hasBottomBar => true;
}
