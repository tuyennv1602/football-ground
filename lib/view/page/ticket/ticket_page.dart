import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/images.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/router/navigation.dart';
import 'package:footballground/router/paths.dart';
import 'package:footballground/view/page/base_widget.dart';
import 'package:footballground/view/widgets/back_drop.dart';
import 'package:footballground/view/widgets/border_background.dart';
import 'package:footballground/view/widgets/input_search.dart';
import 'package:footballground/view/widgets/item_achievement.dart';
import 'package:footballground/view/widgets/item_option.dart';
import 'package:footballground/view/widgets/line_widget.dart';
import 'package:footballground/view/widgets/loading_widget.dart';
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

  _buildCalendarView(BuildContext context) =>
      Column(
        children: <Widget>[
          Expanded(
            child: CalendarCarousel(
              weekdayTextStyle: textStyleMedium(size: 16, color: PRIMARY),
              weekendTextStyle: textStyleRegular(size: 17, color: Colors.red),
              todayTextStyle: textStyleRegular(size: 17, color: Colors.white),
              daysTextStyle: textStyleRegular(size: 17),
              selectedDayButtonColor: PRIMARY,
              todayButtonColor: Colors.white,
              selectedDateTime: DateTime.now(),
              headerTextStyle: textStyleBold(color: PRIMARY, size: 20),
              iconColor: PRIMARY,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: UIHelper.size5),
            child: LineWidget(),
          ),
          Container(
            height: UIHelper.size(85),
            padding: EdgeInsets.all(UIHelper.padding),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ItemAchievement(
                    title: 'Đã đặt',
                    value: '100',
                    colors: GREEN_GRADIENT,
                    icon: Images.ACCEPT,
                  ),
                ),
                SizedBox(width: UIHelper.padding), Expanded(
                  child: ItemAchievement(
                    title: 'Trống',
                    value: '100',
                    colors: ORANGE_GRADIENT,
                    icon: Images.EMPTY_FIELD,),
                ),

                SizedBox(width: UIHelper.padding),
                Expanded(
                  child: ItemAchievement(
                    title: 'Thanh toán',
                    value: '100',
                    colors: PURPLE_GRADIENT,
                    icon: Images.WALLET,
                  ),
                ),
              ],
            ),
          ),
          ItemOption(
            Images.CANCEL,
            'Yêu cầu huỷ sân (10)',
            iconColor: Colors.red,
          ),
          ItemOption(
            Images.TRANSACTION_HISTORY,
            'Chưa thanh toán (10)',
            iconColor: Colors.amber,
          ),
          SizedBox(
            height: UIHelper.size50,
          )
        ],
      );

  _buildTicket(BuildContext context, int index) =>
      DottedBorder(
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
            separatorBuilder: (c, index) =>
                SizedBox(
                  width: UIHelper.size10,
                ),
            shrinkWrap: true,
            itemBuilder: (c, index) => _buildTicket(context, index),
          ),
        ),
      ],
    );
  }

  _buildBookingScheduler(BuildContext context) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InputSearch(
                    hintText: 'Nhập mã vé',
                    onChangedText: (text) {},
                  ),
                ),
                InkWell(
                  onTap: () => Navigation.instance.navigateTo(QR_SCAN),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: UIHelper.size10,
                        bottom: UIHelper.size10,
                        right: UIHelper.size15,
                        left: UIHelper.size10),
                    child: Image.asset(
                      Images.QR_SEARCH,
                      width: UIHelper.size25,
                      height: UIHelper.size25,
                      color: PRIMARY,
                    ),
                  ),
                )
              ],
            ),
            _buildFieldTicket(context, 'Sân số 1'),
            _buildFieldTicket(context, 'Sân số 2'),
            _buildFieldTicket(context, 'Sân số 3')
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: BaseWidget<TicketViewModel>(
        model: TicketViewModel(
          api: Provider.of(context),
        ),
        builder: (c, model, child) {
          var _ground = Provider.of<Ground>(context);
          return model.busy
              ? BorderBackground(
            child: LoadingWidget(),
          )
              : Container(
            color: PRIMARY,
            child: Backdrop(
              key: _backdropKey,
              color: Colors.white,
              backTitle: Align(
                child: Text(
                  'Chọn ngày',
                  style: textStyleTitle(),
                ),
              ),
              frontLayer: Container(
                color: Colors.white,
                child: _buildBookingScheduler(context),
              ),
              backLayer: BorderBackground(
                child: _buildCalendarView(context),
              ),
              frontHeading: Container(
                width: double.infinity,
                height: UIHelper.size40,
                padding: EdgeInsets.only(top: UIHelper.size10),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: PRIMARY,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(UIHelper.radius),
                    topRight: Radius.circular(UIHelper.radius),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF02DC37), PRIMARY]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(0, -1),
                    )
                  ],
                ),
                child: Container(
                  height: UIHelper.size5,
                  width: UIHelper.size50,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(UIHelper.size(4)),
                  ),
                ),
              ),
              frontTitle: Align(
                child: Text(
                  '10/01/2019',
                  style: textStyleTitle(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
