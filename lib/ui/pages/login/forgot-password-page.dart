import 'package:flutter/material.dart';
import 'package:footballground/blocs/forgot-password-bloc.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/fonts.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/stringres.dart';
import 'package:footballground/ui/widgets/button-widget.dart';
import 'package:footballground/ui/widgets/input-widget.dart';
import 'package:footballground/utils/device-util.dart';
import 'package:footballground/utils/validator.dart';

import '../base-page.dart';

// ignore: must_be_immutable
class ForgotPasswordPage extends BasePage<ForgotPasswordBloc> with Validator {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildAppBar(BuildContext context) => null;

  @override
  Widget buildMainContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill)),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ButtonWidget(
                    width: 50,
                    height: 50,
                    onTap: () => Navigator.of(context).pop(),
                    margin:
                        EdgeInsets.only(top: DeviceUtil.getPaddingTop(context)),
                    backgroundColor: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(top: 12, right: 12, bottom: 12),
                      child: Image.asset(
                        Images.LEFT_ARROW,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/icn_logo.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          StringRes.APP_NAME,
                          style: TextStyle(
                              fontFamily: Fonts.BOLD,
                              fontSize: 24,
                              letterSpacing: 0.1,
                              color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          StreamBuilder<bool>(
                            stream: pageBloc.changeTypeStream,
                            builder: (c, snap) => Text(
                              (snap.hasData && snap.data)
                                  ? 'Đổi mật khẩu'
                                  : 'Lấy mã xác nhận',
                              style: Theme.of(context).textTheme.title.copyWith(
                                  fontSize: 20,
                                  color: AppColor.PRIMARY,
                                  fontFamily: Fonts.BOLD),
                            ),
                          ),
                          InputWidget(
                            validator: (value) {
                              if (value.isEmpty)
                                return StringRes.REQUIRED_EMAIL;
                              if (!validEmail(value))
                                return StringRes.EMAIL_INVALID;
                              return null;
                            },
                            labelText: StringRes.EMAIL,
                            onChangedText: (text) =>
                                pageBloc.changeEmailFunc(text),
                          ),
                          StreamBuilder<bool>(
                            stream: pageBloc.changeTypeStream,
                            builder: (c, snap) {
                              if (snap.hasData && snap.data) {
                                return Column(
                                  children: <Widget>[
                                    InputWidget(
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return StringRes.REQUIRED_PASSWORD;
                                        if (!validPassword(value))
                                          return StringRes.PASSWORD_INVALID;
                                        return null;
                                      },
                                      labelText: 'Mật khẩu mới',
                                      obscureText: true,
                                      onChangedText: (text) =>
                                          pageBloc.changePasswordFunc(text),
                                    ),
                                    InputWidget(
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return 'Vui lòng nhập mã xác nhận';
                                        return null;
                                      },
                                      labelText: 'Mã xác nhận',
                                      onChangedText: (text) =>
                                          pageBloc.changeCodeFunc(text),
                                    )
                                  ],
                                );
                              }
                              return Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Một mã xác nhận sẽ được gửi đến email của bạn. Vui lòng kiểm tra email và sử dụng mã xác nhận để thay đổi mật khẩu",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .copyWith(
                                          fontFamily: Fonts.ITALIC,
                                          color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    child: ButtonWidget(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          pageBloc.submit();
                        }
                      },
                      borderRadius: BorderRadius.circular(5),
                      margin: EdgeInsets.only(top: 25, bottom: 25),
                      backgroundColor: AppColor.PRIMARY,
                      child: Text(
                        StringRes.CONFIRM,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  @override
  void listenData(BuildContext context) {
    pageBloc.submitEmailStream.listen((onData) {
      if (!onData.isSuccess) {
        showSnackBar(onData.errorMessage);
      } else {
        showSnackBar(onData.errorMessage, backgroundColor: AppColor.PRIMARY);
        pageBloc.changeTypeFunc(true);
      }
    });
    pageBloc.submitChangePasswordStream.listen((onData) {
      if (!onData.isSuccess) {
        showSnackBar(onData.errorMessage);
      } else {
        showSnackBar('Mật khẩu đã được thay đổi',
            backgroundColor: AppColor.PRIMARY);
        Future.delayed(
            Duration(milliseconds: 5000), () => Navigator.of(context).pop());
      }
    });
  }

  @override
  bool get showFullScreen => true;
}
