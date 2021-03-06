import 'package:flutter/material.dart';
import 'package:footballground/model/user.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/images.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/router/navigation.dart';
import 'package:footballground/router/paths.dart';
import 'package:footballground/view/widgets/app_bar_button.dart';
import 'package:footballground/view/widgets/app_bar_widget.dart';
import 'package:footballground/view/widgets/border_background.dart';
import 'package:footballground/view/widgets/line_widget.dart';
import 'package:footballground/view/widgets/image_widget.dart';
import 'package:footballground/view/widgets/item_option.dart';
import 'package:footballground/view/ui_helper.dart';
import 'package:footballground/util/string_util.dart';
import 'package:footballground/viewmodel/user_vm.dart';
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
                      model: UserViewModel(
                        sharePreferences: Provider.of(context),
                        groundServices: Provider.of(context),
                      ),
                      builder: (context, model, child) => AppBarWidget(
                        leftContent: AppBarButtonWidget(
                          imageName: Images.LOGOUT,
                          onTap: () async {
                            UIHelper.showProgressDialog;
                            await model.logout();
                            UIHelper.hideProgressDialog;
                            Navigation.instance.navigateAndRemove(LOGIN);
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: UIHelper.size20,
                          vertical: UIHelper.size10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'S??? d?? trong v??',
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
                          ItemOption(Images.WALLET_IN, 'N???p ti???n v??o v??',
                              iconColor: Colors.green),
                          ItemOption(Images.WALLET_OUT, 'R??t ti???n',
                              iconColor: Colors.red),
                          ItemOption(
                            Images.TRANSACTIONS,
                            'Chuy???n ti???n',
                            iconColor: Colors.amber,
                          ),
                          ItemOption(
                            Images.TRANSACTION_HISTORY,
                            'L???ch s??? giao d???ch',
                            iconColor: Colors.teal,
                          ),
                          ItemOption(
                            Images.SHARE,
                            'Chia s??? ???ng d???ng',
                            iconColor: Colors.blueAccent,
                          ),
                          ItemOption(
                            Images.INFO,
                            'Th??ng tin ???ng d???ng',
                            iconColor: Colors.blue,
                          ),
                          ItemOption(
                            Images.SETTING,
                            'C??i ?????t',
                            iconColor: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
