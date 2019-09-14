import 'package:flutter/material.dart';
import 'package:footballground/blocs/user-bloc.dart';
import 'package:footballground/models/user.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/app-bar-button.dart';
import 'package:footballground/ui/widgets/divider.dart';
import 'package:footballground/ui/widgets/item-option.dart';
import 'package:footballground/utils/string-util.dart';

import '../base-page.dart';

// ignore: must_be_immutable
class UserPage extends BasePage<UserBloc> {
  @override
  Widget buildAppBar(BuildContext context) => null;

  @override
  Widget buildMainContainer(BuildContext context) => Container(
    color: AppColor.PRIMARY,
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: StreamBuilder<User>(
            stream: appBloc.userStream,
            builder: (c, snap) {
              if (snap.hasData) {
                var _user = snap.data;
                return Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AppBarButtonWidget(
                          imageName: Images.LOGOUT,
                          onTap: () => pageBloc.logoutFunc(true),
                        ),
                        Text(
                          _user.userName,
                          style: Theme.of(context).textTheme.title,
                        ),
                        AppBarButtonWidget(
                          imageName: Images.EDIT_PROFILE,
                          onTap: () {},
                        )
                      ],
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _user.avatar != null
                          ? NetworkImage(_user.avatar)
                          : AssetImage(Images.DEFAULT_AVATAR),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            child: Container(
              color: Colors.white,
              child: Column(children: <Widget>[
                StreamBuilder<User>(
                    stream: appBloc.userStream,
                    builder: (c, snap) {
                      if (snap.hasData) {
                        var wallet = snap.data.wallet != null
                            ? StringUtil.formatCurrency(
                            snap.data.wallet * 1000)
                            : '0đ';
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Số dư trong ví',
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(color: AppColor.BLACK_TEXT),
                              ),
                              Text(
                                '$wallet',
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(color: AppColor.BLACK_TEXT),
                              ),
                            ],
                          ),
                        );
                      }
                      return SizedBox();
                    }),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DividerWidget(),
                      ItemOptionWidget(Images.WALLET_IN, 'Nạp tiền',
                          iconColor: Colors.green),
                      DividerWidget(),
                      ItemOptionWidget(Images.WALLET_OUT, 'Rút tiền',
                          iconColor: Colors.red),
                      DividerWidget(),
                      ItemOptionWidget(
                        Images.TRANSACTIONS,
                        'Chuyển tiền',
                        iconColor: Colors.amber,
                      ),
                      DividerWidget(),
                      ItemOptionWidget(
                        Images.TRANSACTION_HISTORY,
                        'Lịch sử giao dịch',
                        iconColor: Colors.teal,
                      ),
                      DividerWidget(),
                      ItemOptionWidget(
                        Images.SHARE,
                        'Chia sẻ ứng dụng',
                        iconColor: Colors.blueAccent,
                      ),
                      DividerWidget(),
                      ItemOptionWidget(
                        Images.INFO,
                        'Thông tin ứng dụng',
                        iconColor: Colors.blue,
                      ),
                      DividerWidget(),
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
        )
      ],
    ),
  );

  @override
  void listenData(BuildContext context) {
    pageBloc.logoutStream.listen((result) {
      if (result) {
        Routes.routeToLoginPage(context);
      } else {
        showSnackBar('Lỗi');
      }
    });
  }

  @override
  bool get hasBottomBar => true;
}
