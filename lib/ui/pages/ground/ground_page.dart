import 'package:flutter/material.dart';
import 'package:footballground/models/user.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/pages/base_widget.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/back_drop.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:footballground/ui/widgets/loading.dart';
import 'package:footballground/utils/ui_helper.dart';
import 'package:footballground/viewmodels/ground_viewmodel.dart';
import 'package:provider/provider.dart';

class GroundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GroundState();
  }
}

class GroundState extends State<GroundPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final GlobalKey<BackdropState> _backdropKey =
      GlobalKey<BackdropState>(debugLabel: 'Backdrop');

  Widget _buildEmptyGround(BuildContext context) => InkWell(
        onTap: () => Routes.routeToLocation(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              Images.ADD_GROUND,
              width: UIHelper.size50,
              height: UIHelper.size50,
              color: PRIMARY,
            ),
            UIHelper.verticalSpaceMedium,
            Text(
              'Tạo sân bóng',
              style: textStyleTitle(color: BLACK_TEXT),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UIHelper().init(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: BaseWidget<GroundViewModel>(
        model: GroundViewModel(
          api: Provider.of(context),
          authServices: Provider.of(context),
        ),
        onModelReady: (model) async {
          var resp = await model.refreshToken();
          if (!resp.isSuccess) {
            UIHelper.showSimpleDialog(resp.getErrorMessage,
                onTap: () => Routes.routeToLogin(context));
          }
        },
        builder: (c, model, child) {
          var _user = Provider.of<User>(context);
          var _ground = _user != null ? _user.ground : null;
          bool _hasGround = _ground != null;
          return Column(
            children: <Widget>[
              _hasGround
                  ? SizedBox()
                  : AppBarWidget(
                      centerContent: Text(
                        'Sân bóng',
                        textAlign: TextAlign.center,
                        style: textStyleTitle(),
                      ),
                    ),
              Expanded(
                child: model.busy
                    ? BorderBackground(
                        child: LoadingWidget(),
                      )
                    : _hasGround
                        ? Container(
                            padding: EdgeInsets.only(top: UIHelper.paddingTop),
                            color: PRIMARY,
                            child: Backdrop(
                              key: _backdropKey,
                              color: Colors.white,
                              backTitle: Align(
                                child: Text(
                                  _ground.name,
                                  style: textStyleTitle(),
                                ),
                              ),
                              frontLayer: Container(
                                color: Colors.white,
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  children: <Widget>[Text('Thông tin đặt sân')],
                                ),
                              ),
                              backLayer: BorderBackground(
                                child: Text('ground manager'),
                              ),
                              frontTitle: Align(
                                child: Text(
                                  'Lịch đặt sân',
                                  style: textStyleTitle(),
                                ),
                              ),
                            ),
                          )
                        : _buildEmptyGround(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
