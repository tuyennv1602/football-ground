import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/fonts.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/view/page/analytic/analytic_page.dart';
import 'package:footballground/view/page/base_widget.dart';
import 'package:footballground/view/page/ground/ground_page.dart';
import 'package:footballground/view/page/notification/notification_page.dart';
import 'package:footballground/view/page/user/user_page.dart';
import 'package:footballground/view/ui_helper.dart';
import 'package:footballground/view/widgets/app_bar_widget.dart';
import 'package:footballground/view/widgets/border_background.dart';
import 'package:footballground/view/widgets/loading_widget.dart';
import 'package:footballground/viewmodel/home_vm.dart';
import 'package:provider/provider.dart';
import 'ticket/ticket_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final List<BottomNavigationBarItem> fullTabBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.apps, size: 25),
      title:
          Text('Sân bóng', style: TextStyle(fontSize: 10, fontFamily: REGULAR)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.show_chart, size: 25),
      title:
          Text('Thống kê', style: TextStyle(fontSize: 10, fontFamily: REGULAR)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt, size: 25),
      title: Text('Lịch đặt sân',
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

  final List<BottomNavigationBarItem> shortTabBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.apps, size: 25),
      title:
          Text('Sân bóng', style: TextStyle(fontSize: 10, fontFamily: REGULAR)),
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

  _buildLoading() => Column(
        children: <Widget>[
          AppBarWidget(
            centerContent: Text(
              'Sân bóng',
              textAlign: TextAlign.center,
              style: textStyleTitle(),
            ),
          ),
          Expanded(
            child: BorderBackground(child: LoadingWidget()),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    UIHelper().init(context);
    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(
        authServices: Provider.of(context),
        groundServices: Provider.of(context),
      ),
      onModelReady: (model) => model.refreshToken(),
      builder: (c, model, child) {
        var _ground = Provider.of<Ground>(context);
        return model.busy
            ? Scaffold(
                backgroundColor: PRIMARY,
                body: _buildLoading(),
              )
            : CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  backgroundColor: Colors.white,
                  activeColor: PRIMARY,
                  items: _ground == null ? shortTabBarItems : fullTabBarItems,
                  currentIndex: _ground == null ? 0 : 2,
                ),
                tabBuilder: (BuildContext context, int index) {
                  if (index == 0)
                    return CupertinoTabView(
                        builder: (BuildContext context) => GroundPage());
                  if (index == 1)
                    return CupertinoTabView(
                        builder: (BuildContext context) => _ground == null
                            ? NotificationPage()
                            : AnalyticPage());
                  if (index == 2)
                    return CupertinoTabView(
                        builder: (BuildContext context) =>
                            _ground == null ? UserPage() : TicketPage());
                  if (index == 3)
                    return CupertinoTabView(
                        builder: (BuildContext context) => NotificationPage());
                  if (index == 4)
                    return CupertinoTabView(
                        builder: (BuildContext context) => UserPage());
                  return null;
                },
              );
      },
    );
  }
}
