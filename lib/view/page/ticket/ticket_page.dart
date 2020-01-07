import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/images.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/router/navigation.dart';
import 'package:footballground/router/paths.dart';
import 'package:footballground/view/page/base_widget.dart';
import 'package:footballground/view/widgets/app_bar_widget.dart';
import 'package:footballground/view/widgets/back_drop.dart';
import 'package:footballground/view/widgets/border_background.dart';
import 'package:footballground/view/widgets/item_option_widget.dart';
import 'package:footballground/view/widgets/line_widget.dart';
import 'package:footballground/view/widgets/loading_widget.dart';
import 'package:footballground/view/widgets/tabbar_widget.dart';
import 'package:footballground/view/ui_helper.dart';
import 'package:footballground/viewmodel/ticket_vm.dart';
import 'package:provider/provider.dart';

class TicketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TicketState();
  }
}

class _TicketState extends State<TicketPage>
    with AutomaticKeepAliveClientMixin {
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

  _buildEmptyGround(BuildContext context) => InkWell(
        onTap: () => Navigation.instance.navigateTo(LOCATION),
        child: BorderBackground(
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
                padding: EdgeInsets.only(top: UIHelper.size10),
                child: Text(
                  'Tạo sân bóng',
                  style: textStyleTitle(color: BLACK_TEXT),
                ),
              ),
            ],
          ),
        ),
      );

  _buildGroundDetail(BuildContext context, Ground ground) => ListView(
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
                      placeholder: Images.LOADING,
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
            iconColor: Colors.green,
          ),
          LineWidget(),
          ItemOptionWidget(
            Images.LOCATION,
            ground.address,
            iconColor: Colors.blueAccent,
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
                  onTap: () => Navigation.instance.navigateTo(CREATE_FIELD,
                      arguments: ground.countField + 1),
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
          ground.countField > 0
              ? Column(
                  children: ground.fields
                      .map((field) => ItemOptionWidget(
                            Images.FIELD,
                            field.name,
                            iconColor: Colors.green,
                          ))
                      .toList(),
                )
              : Padding(
                  padding: EdgeInsets.all(UIHelper.size15),
                  child: Text(
                    'Bạn chưa thêm sân. Click (+) để thêm sân',
                    textAlign: TextAlign.center,
                    style: textStyleRegular(),
                  ),
                ),
        ],
      );

  _buildTicket(BuildContext context, int index) => DottedBorder(
        color: PRIMARY,
        strokeWidth: 1,
        dashPattern: [5, 3, 2, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(UIHelper.size10),
        child: Container(
          width: UIHelper.size(150),
          padding: EdgeInsets.all(UIHelper.size10),
          color: GREY_BACKGROUND,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '18:00 - 19:30',
                style: textStyleSemiBold(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: UIHelper.size5),
                  child: Text(
                    index % 2 == 0 ? 'Acazia FC' : 'Đội bóng của Tuyển',
                    maxLines: 2,
                    style: textStyleRegular(),
                  ),
                ),
              ),
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

  _buildFieldTicket(BuildContext context, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: UIHelper.size10),
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

  _buildBookingScheduler(BuildContext context) {
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
            ),
          )
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
      body: BaseWidget<TicketViewModel>(
        model: TicketViewModel(
          api: Provider.of(context),
        ),
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
                                      height: UIHelper.size50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3,
                                            offset: Offset(0, -1),
                                          )
                                        ],
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