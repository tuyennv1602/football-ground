import 'package:flutter/material.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/images.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/view/ui_helper.dart';
import 'package:footballground/view/widgets/app_bar_widget.dart';
import 'package:footballground/view/widgets/border_background.dart';
import 'package:provider/provider.dart';

class GroundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroundState();
}

class _GroundState extends State<GroundPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  _buildEmptyGround() => Column(
        children: <Widget>[
          AppBarWidget(
            centerContent: Text(
              "Sân bóng",
              textAlign: TextAlign.center,
              style: textStyleTitle(),
            ),
          ),
          Expanded(
            child: BorderBackground(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: UIHelper.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      Images.ADD_GROUND,
                      width: UIHelper.size50,
                      height: UIHelper.size50,
                      color: PRIMARY,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: UIHelper.size20),
                      child: Text(
                        'Bạn chưa sở hữu sân bóng trong hệ thống. Vui vòng tạo sân bóng để bắt đầu quản lý sân bóng của bạn',
                        style:
                            textStyleMediumTitle(color: BLACK_TEXT, size: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var _ground = Provider.of<Ground>(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: _ground == null
          ? _buildEmptyGround()
          : Stack(
              children: <Widget>[

              ],
            ),
    );
  }
}
