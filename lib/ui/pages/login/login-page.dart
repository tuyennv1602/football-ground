import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:footballground/blocs/login-bloc.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/fonts.dart';
import 'package:footballground/res/stringres.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/button-widget.dart';
import 'package:footballground/ui/widgets/input-widget.dart';
import 'package:footballground/utils/size-config.dart';
import 'package:footballground/utils/validator.dart';

import '../base-page.dart';

// ignore: must_be_immutable
class LoginPage extends BasePage<LoginBloc> with Validator {
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
                          Text(
                            StringRes.LOGIN,
                            style: Styles.bold(color: AppColor.PRIMARY),
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
                          InputWidget(
                            validator: (value) {
                              if (value.isEmpty)
                                return StringRes.REQUIRED_PASSWORD;
                              if (!validPassword(value))
                                return StringRes.PASSWORD_INVALID;
                              return null;
                            },
                            labelText: StringRes.PASSWORD,
                            obscureText: true,
                            onChangedText: (text) =>
                                pageBloc.changePasswordFunc(text),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ButtonWidget(
                        backgroundColor: Colors.transparent,
                        onTap: () => Routes.routeToForgotPasswordPage(context),
                        child: Text(
                          StringRes.FORGOT_PASSWORD,
                          style: Styles.button(),
                        ),
                      ),
                      ButtonWidget(
                        width: (SizeConfig.screenWidth - size40) / 2,
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            pageBloc.submitLoginEmailFunc(true);
                          }
                        },
                        borderRadius: BorderRadius.circular(size5),
                        margin: EdgeInsets.symmetric(vertical: size30),
                        backgroundColor: AppColor.PRIMARY,
                        child: Text(
                          StringRes.LOGIN.toUpperCase(),
                          style: Styles.button(),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColor.LINE_COLOR,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size10),
                        child: Text(
                          StringRes.LOGIN_VIA,
                          style: Styles.regular(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColor.LINE_COLOR,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: size45,
                        onPressed: () => showConfirmDialog(
                            context, "data.errorMessage",
                            onConfirmed: () => Navigator.of(context).pop()),
                        icon: Image.asset('assets/images/icn_facebook.png'),
                      ),
                      IconButton(
                        iconSize: size45,
                        onPressed: () => print('google'),
                        icon: Image.asset('assets/images/icn_google.png'),
                      )
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Bạn chưa có tài khoản? ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.size(16)),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Đăng ký ngay',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontFamily: Fonts.SEMI_BOLD,
                                      color: Colors.white,
                                      fontSize: SizeConfig.size(18)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Routes.routeToRegisterPage(context)),
                            ]),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  @override
  void listenData(BuildContext context) {
    pageBloc.loginEmailStream.listen((response) {
      if (!response.isSuccess) {
        showSnackBar(response.errorMessage);
      } else {
        appBloc.updateUser();
        Routes.routeToHomePage(context);
      }
    });
  }

  @override
  bool get showFullScreen => true;
}
