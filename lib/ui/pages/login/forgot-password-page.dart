import 'package:flutter/material.dart';
import 'package:footballground/blocs/forgot-password-bloc.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/stringres.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/widgets/button-widget.dart';
import 'package:footballground/ui/widgets/input-widget.dart';
import 'package:footballground/utils/size-config.dart';
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
      padding: EdgeInsets.symmetric(horizontal: size20),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill)),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: size20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ButtonWidget(
                    width: size50,
                    height: size50,
                    onTap: () => Navigator.of(context).pop(),
                    margin: EdgeInsets.only(top: SizeConfig.paddingTop),
                    backgroundColor: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: size15, right: size15, bottom: size15),
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
                          width: size50,
                          height: size50,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: size15,
                        ),
                        Text(
                          StringRes.APP_NAME,
                          style: Styles.appName(),
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
                    padding: EdgeInsets.all(size10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size5)),
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
                              style: Styles.bold(color: AppColor.PRIMARY),
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
                                padding: EdgeInsets.only(top: size10),
                                child: Text(
                                  "Một mã xác nhận sẽ được gửi đến email của bạn. Vui lòng kiểm tra email và sử dụng mã xác nhận để thay đổi mật khẩu",
                                  style: Styles.italic(color: Colors.grey),
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
                      borderRadius: BorderRadius.circular(size5),
                      margin: EdgeInsets.symmetric(vertical: size25),
                      backgroundColor: AppColor.PRIMARY,
                      child: Text(
                        StringRes.CONFIRM,
                        style: Styles.button(),
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
        showSnackBar('Mã xác nhận đã được gửi',
            backgroundColor: AppColor.PRIMARY);
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
