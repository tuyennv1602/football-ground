import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footballground/blocs/app-bloc.dart';
import 'package:footballground/blocs/base-bloc.dart';
import 'package:footballground/blocs/ground-bloc.dart';
import 'package:footballground/blocs/noti-bloc.dart';
import 'package:footballground/blocs/social-bloc.dart';
import 'package:footballground/blocs/user-bloc.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/ui/pages/social-page.dart';
import 'package:footballground/ui/pages/user/user-page.dart';
import 'package:footballground/ui/routes/routes.dart';

import 'ground/ground-page.dart';
import 'notify/noti-page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  AppBloc _appBloc;

  final _userTab = BlocProvider<UserBloc>(
    bloc: UserBloc(),
    child: UserPage(),
  );

  final _notifyTab = BlocProvider<NotiBloc>(
    bloc: NotiBloc(),
    child: NotiPage(),
  );

  final _groundTab = BlocProvider<GroundBloc>(
    bloc: GroundBloc(),
    child: GroundPage(),
  );

  final _socialTab = BlocProvider<SocialBloc>(
    bloc: SocialBloc(),
    child: SocialPage(),
  );

  final List<BottomNavigationBarItem> tabBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.rss_feed, size: 25),
      title: Text('Cộng đồng', style: TextStyle(fontSize: 10)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.flag, size: 25),
      title: Text('Sân bóng', style: TextStyle(fontSize: 10)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications, size: 25),
      title: Text('Thông báo', style: TextStyle(fontSize: 10)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle, size: 25),
      title: Text(
        'Cá nhân',
        style: TextStyle(fontSize: 10),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_appBloc == null) {
      _appBloc = BlocProvider.of<AppBloc>(context);
      _appBloc.refreshTokenStream.listen((result) {
        if (!result) Routes.routeToLoginPage(context);
      });
    }
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: AppColor.GREEN,
        items: tabBarItems,
        currentIndex: 0,
      ),
      tabBuilder: (BuildContext context, int index) {
        if (index == 0) return CupertinoTabView(builder: (BuildContext context) => _socialTab);
        if (index == 1) return CupertinoTabView(builder: (BuildContext context) => _groundTab);
        if (index == 2) return CupertinoTabView(builder: (BuildContext context) => _notifyTab);
        if (index == 3) return CupertinoTabView(builder: (BuildContext context) => _userTab);
        return null;
      },
    );
  }
}
