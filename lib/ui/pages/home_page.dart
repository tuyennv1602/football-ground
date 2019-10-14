import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/fonts.dart';
import 'package:footballground/ui/pages/notification/notification_page.dart';
import 'package:footballground/ui/pages/social/social_page.dart';
import 'package:footballground/ui/pages/user/user_page.dart';
import 'ground/ground_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final List<BottomNavigationBarItem> tabBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.apps, size: 25),
      title:
          Text('Sân bóng', style: TextStyle(fontSize: 10, fontFamily: REGULAR)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.rss_feed, size: 25),
      title: Text('Cộng đồng',
          style: TextStyle(fontSize: 10, fontFamily: REGULAR)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications, size: 25),
      title: Text('Thông báo',
          style: TextStyle(fontSize: 10, fontFamily: REGULAR)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle, size: 25),
      title: Text(
        'Cá nhân',
        style: TextStyle(fontSize: 10, fontFamily: REGULAR),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: PRIMARY,
        items: tabBarItems,
        currentIndex: 0,
      ),
      tabBuilder: (BuildContext context, int index) {
        if (index == 0)
          return CupertinoTabView(
              builder: (BuildContext context) => GroundPage());
        if (index == 1)
          return CupertinoTabView(
              builder: (BuildContext context) => SocialPage());
        if (index == 2)
          return CupertinoTabView(
              builder: (BuildContext context) => NotificationPage());
        if (index == 3)
          return CupertinoTabView(builder: (BuildContext context) => UserPage());
        return null;
      },
    );
  }
}
