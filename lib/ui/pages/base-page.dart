import 'package:flutter/material.dart';
import 'package:footballground/blocs/app-bloc.dart';
import 'package:footballground/blocs/base-bloc.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/stringres.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/widgets/app-bar-widget.dart';
import 'package:footballground/ui/widgets/button-widget.dart';
import 'package:footballground/ui/widgets/loading.dart';
import 'package:footballground/utils/size-config.dart';

// ignore: must_be_immutable
abstract class BasePage<T extends BaseBloc> extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  T pageBloc;

  AppBloc appBloc;

  Widget buildMainContainer(BuildContext context);

  void listenData(BuildContext context);

  Widget buildAppBar(BuildContext context);

  bool showFullScreen = false;

  // set true if need scroll all textfield

  bool resizeAvoidPadding = false;

  double get size5 => SizeConfig.size(5);

  double get size10 => SizeConfig.size(10);

  double get size15 => SizeConfig.size(15);

  double get size20 => SizeConfig.size(20);

  double get size25 => SizeConfig.size(25);

  double get size30 => SizeConfig.size(30);

  double get size35 => SizeConfig.size(35);

  double get size40 => SizeConfig.size(40);

  double get size45 => SizeConfig.size(45);

  double get size50 => SizeConfig.size(50);

  void showSnackBar(String message,
      {Color backgroundColor, Duration duration}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: duration ?? Duration(milliseconds: 5000),
      backgroundColor: backgroundColor ?? Colors.red,
      content: Text(message),
    ));
  }

  void showSimpleDialog(BuildContext context, String message,
      {Function onTap}) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size5),
            ),
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(size15),
                  child: Column(
                    children: <Widget>[
                      Text(
                        StringRes.NOTIFY,
                        style: Styles.semiBold(size: 18),
                      ),
                      SizedBox(
                        height: size10,
                      ),
                      Text(message, style: Styles.regular(size: 16))
                    ],
                  ),
                ),
                Align(
                  child: ButtonWidget(
                    onTap: () {
                      onTap();
                      Navigator.of(context).pop();
                    },
                    height: size40,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(size5),
                        bottomRight: Radius.circular(size5)),
                    backgroundColor: AppColor.PRIMARY,
                    child: Text(
                      StringRes.OK,
                      style: Styles.button(),
                    ),
                  ),
                ),
              ],
            ),
          ));

  void showConfirmDialog(BuildContext context, String message,
      {Function onConfirmed}) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size5),
            ),
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(size15),
                  child: Column(
                    children: <Widget>[
                      Text(
                        StringRes.NOTIFY,
                        style: Styles.semiBold(size: 18),
                      ),
                      SizedBox(
                        height: size10,
                      ),
                      Text(
                        message,
                        style: Styles.regular(size: 16),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ButtonWidget(
                        onTap: () => Navigator.of(context).pop(),
                        height: size40,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(size5)),
                        backgroundColor: Colors.grey,
                        child: Text(
                          StringRes.CANCEL,
                          style: Styles.button(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ButtonWidget(
                        onTap: () {
                          onConfirmed();
                          Navigator.of(context).pop();
                        },
                        height: size40,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(size5)),
                        backgroundColor: AppColor.PRIMARY,
                        child: Text(
                          StringRes.OK,
                          style: Styles.button(),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ));

  void hideKeyBoard(BuildContext context) =>
      FocusScope.of(context).requestFocus(new FocusNode());

  @override
  Widget build(BuildContext context) {
    if (appBloc == null) {
      appBloc = BlocProvider.of<AppBloc>(context);
    }
    if (pageBloc == null) {
      pageBloc = BlocProvider.of<T>(context);
    }
    listenData(context);
    SizeConfig().init(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.PRIMARY,
      resizeToAvoidBottomPadding: resizeAvoidPadding,
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              !showFullScreen
                  ? Container(
                height: SizeConfig.paddingTop,
                color: AppColor.PRIMARY,
              )
                  : SizedBox(),
              buildAppBar(context) ?? SizedBox(),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => hideKeyBoard(context),
                  child: SizedBox(
                    width: SizeConfig.screenWidth,
                    child: buildMainContainer(context),
                  ),
                ),
              ),
              !showFullScreen
                  ? SizedBox(height: SizeConfig.paddingBottom)
                  : SizedBox()
            ],
          ),
          StreamBuilder<bool>(
            stream: pageBloc.loadingStream,
            builder: (c, snap) {
              bool isLoading = snap.hasData && snap.data;
              return LoadingWidget(
                show: isLoading,
              );
            },
          )
        ],
      ),
    );
  }
}
