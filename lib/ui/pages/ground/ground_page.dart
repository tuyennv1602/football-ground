import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:footballground/models/ground.dart';
import 'package:footballground/models/user.dart';
import 'package:footballground/provider_setup.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/pages/base_widget.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/back_drop.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:footballground/ui/widgets/item_option_widget.dart';
import 'package:footballground/ui/widgets/line_widget.dart';
import 'package:footballground/ui/widgets/loading_widget.dart';
import 'package:footballground/ui/widgets/tabbar_widget.dart';
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

  static const TABS = [
    'T5 17/10',
    'T6 18/10',
    'T7 19/10',
    'CN 20/10',
    'T2 21/10',
    'T3 22/10',
    'T4 23/10'
  ];

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

  Widget _buildGroundDetail(BuildContext context, Ground ground) => ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: UIHelper.size(200),
            color: GREY_BACKGROUND,
            child: InkWell(
              child: ground.avatar == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(Images.GALLERY,
                            width: UIHelper.size50,
                            height: UIHelper.size50,
                            color: Colors.grey),
                      ],
                    )
                  : FadeInImage.assetNetwork(
                      image: ground.avatar,
                      placeholder: Images.GALLERY,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(UIHelper.size10),
            child: Text(
              'Thông tin chung',
              style: textStyleSemiBold(color: PRIMARY),
            ),
          ),
          ItemOptionWidget(
            Images.PHONE,
            ground.phone,
            iconColor: Colors.blueAccent,
          ),
          LineWidget(),
          ItemOptionWidget(
            Images.LOCATION,
            ground.address,
            iconColor: Colors.green,
          ),
          LineWidget(),
          ItemOptionWidget(
            Images.REGION,
            ground.getRegion,
            iconColor: Colors.red,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: UIHelper.size10),
                child: Text(
                  'Quản lý sân',
                  style: textStyleSemiBold(color: PRIMARY),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(UIHelper.size10),
                child: InkWell(
                  onTap: () => Routes.routeToCreateField(
                      context, false, ground.countField + 1),
                  child: Image.asset(
                    Images.ADD,
                    width: UIHelper.size20,
                    height: UIHelper.size20,
                    color: PRIMARY,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(UIHelper.size10),
            child: ground.countField > 0
                ? Text('has field')
                : Text(
                    'Bạn chưa thêm sân. Click (+) để thêm sân',
                    textAlign: TextAlign.center,
                    style: textStyleRegularTitle(),
                  ),
          )
        ],
      );

  Widget _buildTicket(BuildContext context, int index) => DottedBorder(
        color: PRIMARY,
        strokeWidth: 1,
        dashPattern: [5, 3, 2, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(UIHelper.size5),
        child: Container(
          width: UIHelper.size(150),
          padding: EdgeInsets.all(UIHelper.size5),
          color: GREY_BACKGROUND,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '18:00 - 19:30',
                style: textStyleSemiBold(),
              ),
              UIHelper.verticalSpaceSmall,
              Expanded(
                child: Text(
                  index % 2 == 0 ? 'Acazia FC' : 'Đội bóng của Tuyển',
                  maxLines: 2,
                  style: textStyleRegularTitle(),
                ),
              ),
              UIHelper.verticalSpaceSmall,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  index % 2 == 0 ? 'Đặt thành công' : 'Đã thanh toán',
                  style: textStyleRegularBody(
                      color: index % 2 == 0 ? Colors.green : Colors.grey),
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildFieldTicket(BuildContext context, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: UIHelper.size5),
          child: Text(
            name,
            style: textStyleSemiBold(color: PRIMARY, size: 18),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: UIHelper.size10),
          height: UIHelper.size(105),
          child: ListView.separated(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            separatorBuilder: (c, index) => SizedBox(
              width: UIHelper.size10,
            ),
            shrinkWrap: true,
            itemBuilder: (c, index) => _buildTicket(context, index),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingScheduler(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: Column(
        children: <Widget>[
          TabBarWidget(
            isScrollable: true,
            titles: TABS,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(UIHelper.size10),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildFieldTicket(context, 'Sân số 1'),
                _buildFieldTicket(context, 'Sân số 2'),
                _buildFieldTicket(context, 'Sân số 3')
              ],
            ),
          ))
        ],
      ),
    );
  }

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
            groundServices: Provider.of(context)),
        onModelReady: (model) async {
          var resp = await model.refreshToken();
          if (!resp.isSuccess) {
            UIHelper.showSimpleDialog(resp.getErrorMessage,
                onTap: () => Routes.routeToLogin(context));
          }
        },
        builder: (c, model, child) {
          var _ground = Provider.of<Ground>(context);
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
                                child: _buildBookingScheduler(context),
                              ),
                              backLayer: BorderBackground(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child:
                                          _buildGroundDetail(context, _ground),
                                    ),
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: PRIMARY,
                                        borderRadius: BorderRadius.only(
                                          topLeft:
                                              Radius.circular(UIHelper.size15),
                                          topRight:
                                              Radius.circular(UIHelper.size15),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
