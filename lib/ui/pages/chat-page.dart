import 'package:flutter/material.dart';
import 'package:footballground/blocs/chat-bloc.dart';
import 'package:footballground/ui/widgets/app-bar-widget.dart';

import 'base-page.dart';

// ignore: must_be_immutable
class ChatPage extends BasePage<ChatBloc> {
  @override
  Widget buildAppBar(BuildContext context) => AppBarWidget(
        centerContent: Text(
          "Chat",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.title,
        ),
      );

  @override
  Widget buildMainContainer(BuildContext context) {
    return Container(
      child: Text("chat"),
    );
  }

  @override
  void listenData(BuildContext context) {}
}
