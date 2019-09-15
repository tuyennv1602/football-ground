import 'package:flutter/material.dart';
import 'package:footballground/blocs/user-bloc.dart';
import 'package:footballground/models/user.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/app-bar-button.dart';
import 'package:footballground/ui/widgets/border-background.dart';
import 'package:footballground/ui/widgets/line.dart';
import 'package:footballground/ui/widgets/image-widget.dart';
import 'package:footballground/ui/widgets/item-option.dart';
import 'package:footballground/utils/size-config.dart';
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
              padding: EdgeInsets.only(bottom: size20),
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
                              _user.name ?? _user.userName,
                              style: Styles.title(),
                            ),
                            AppBarButtonWidget(
                              imageName: Images.EDIT,
                              onTap: () {},
                            )
                          ],
                        ),
                        ImageWidget(
                          source: _user.avatar,
                          placeHolder: Images.DEFAULT_AVATAR,
                          size: SizeConfig.size(100),
                          radius: SizeConfig.size(50),
                        )
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
            Expanded(
              child: BorderBackground(
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
                                horizontal: size20, vertical: size10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Số dư trong ví',
                                  style:
                                      Styles.title(color: AppColor.BLACK_TEXT),
                                ),
                                Text(
                                  '$wallet',
                                  style:
                                      Styles.title(color: AppColor.BLACK_TEXT),
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
}
