import 'package:flutter/material.dart';
import 'package:footballground/models/ground.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/app_bar_button.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:footballground/utils/ui_helper.dart';

class CreateFieldPage extends StatelessWidget {

  Future<bool> _onWillPop(BuildContext context) {
    return Routes.routeToHome2(context) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    UIHelper().init(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: PRIMARY,
          body: Column(
            children: <Widget>[
              AppBarWidget(
                centerContent: Text(
                  'Thông tin sân bóng',
                  textAlign: TextAlign.center,
                  style: textStyleTitle(),
                ),
                leftContent: AppBarButtonWidget(
                  imageName: Images.BACK,
                  onTap: () => Routes.routeToHome2(context),
                ),
              ),
              Expanded(
                child: BorderBackground(
                  child: Text('data'),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () => _onWillPop(context));
  }
}
