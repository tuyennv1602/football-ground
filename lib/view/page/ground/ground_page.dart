import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      backgroundColor: Colors.white,
      body: _ground == null
          ? _buildEmptyGround()
          : Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: UIHelper.size(210) + UIHelper.paddingTop,
                  padding: EdgeInsets.symmetric(horizontal: UIHelper.size15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _ground.avatar != null
                          ? NetworkImage(_ground.avatar)
                          : AssetImage(Images.DEFAULT_GROUND),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: UIHelper.size(90) + UIHelper.paddingTop),
                  height: UIHelper.size(120),
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                      UIHelper.size10, 0, UIHelper.size10, UIHelper.size30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: BLACK_GRADIENT,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      _ground.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleTitle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: UIHelper.size(190) + UIHelper.paddingTop),
                  child: BorderBackground(
                    child: Column(
                      children: <Widget>[],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
