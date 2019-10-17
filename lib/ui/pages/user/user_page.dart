import 'package:flutter/material.dart';
import 'package:footballground/models/user.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/app_bar_button.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:footballground/ui/widgets/line_widget.dart';
import 'package:footballground/ui/widgets/image_widget.dart';
import 'package:footballground/ui/widgets/item_option_widget.dart';
import 'package:footballground/utils/ui_helper.dart';
import 'package:footballground/utils/string_util.dart';
import 'package:footballground/viewmodels/user_viewmodel.dart';
import 'package:provider/provider.dart';

import '../base_widget.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserState();
  }
}

class UserState extends State<UserPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UIHelper().init(context);
    var _user = Provider.of<User>(context);
    var wallet = StringUtil.formatCurrency(_user.wallet * 1000);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: PRIMARY,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: UIHelper.size20),
                child: Column(
                  children: <Widget>[
                    BaseWidget<UserViewModel>(
                      model:
                          UserViewModel(sharePreferences: Provider.of(context)),
                      builder: (context, model, child) => AppBarWidget(
                        leftContent: AppBarButtonWidget(
                          imageName: Images.LOGOUT,
                          onTap: () async {
                            UIHelper.showProgressDialog;
                            await model.logout();
                            UIHelper.hideProgressDialog;
                            Routes.routeToLogin(_scaffoldKey.currentContext);
                          },
                        ),
                        centerContent: Text(_user.name ?? _user.userName,
                            textAlign: TextAlign.center,
                            style: textStyleTitle()),
                        rightContent: AppBarButtonWidget(
                          imageName: Images.EDIT,
                          onTap: () {},
                        ),
                      ),
                    ),
                    ImageWidget(
                      source: _user.avatar,
                      placeHolder: Images.DEFAULT_AVATAR,
                      size: UIHelper.size(100),
                      radius: UIHelper.size(50),
                    )
                  ],
                )),
            Expanded(
              child: BorderBackground(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: UIHelper.size20, vertical: UIHelper.size10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Số dư trong ví',
                          style: textStyleTitle(color: BLACK_TEXT),
                        ),
                        Text(
                          '$wallet',
                          style: textStyleTitle(color: BLACK_TEXT),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        LineWidget(),
                        ItemOptionWidget(Images.WALLET_IN, 'Nạp tiền vào ví',
                            iconColor: Colors.green),
                        LineWidget(),
                        ItemOptionWidget(Images.WALLET_OUT, 'Rút tiền',
                            iconColor: Colors.red),
                        LineWidget(),
                        ItemOptionWidget(
                          Images.TRANSACTIONS,
                          'Chuyển tiền',
                          iconColor: Colors.amber,
                        ),
                        LineWidget(),
                        ItemOptionWidget(
                          Images.TRANSACTION_HISTORY,
                          'Lịch sử giao dịch',
                          iconColor: Colors.teal,
                        ),
                        LineWidget(),
                        ItemOptionWidget(
                          Images.SHARE,
                          'Chia sẻ ứng dụng',
                          iconColor: Colors.blueAccent,
                        ),
                        LineWidget(),
                        ItemOptionWidget(
                          Images.INFO,
                          'Thông tin ứng dụng',
                          iconColor: Colors.blue,
                        ),
                        LineWidget(),
                        ItemOptionWidget(
                          Images.SETTING,
                          'Cài đặt',
                          iconColor: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
