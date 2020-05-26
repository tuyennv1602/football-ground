import 'package:flutter/material.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/model/time_slot.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/images.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/ground_services.dart';
import 'package:footballground/view/page/base_widget.dart';
import 'package:footballground/view/widgets/app_bar_button.dart';
import 'package:footballground/view/widgets/app_bar_widget.dart';
import 'package:footballground/view/widgets/border_background.dart';
import 'package:footballground/view/widgets/choose_field_type.dart';
import 'package:footballground/view/widgets/input_price_widget.dart';
import 'package:footballground/view/widgets/line_widget.dart';
import 'package:footballground/view/widgets/tabbar_widget.dart';
import 'package:footballground/view/widgets/time_slider_widget.dart';
import 'package:footballground/util/constants.dart';
import 'package:footballground/util/date_util.dart';
import 'package:footballground/util/string_util.dart';
import 'package:footballground/view/ui_helper.dart';
import 'package:footballground/viewmodel/create_field_vm.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreateFieldPage extends StatelessWidget {
  final int _number;
  int type = Constants.VS7;

  CreateFieldPage({@required int number}) : _number = number;

  Widget _buildItemTimeSlot(BuildContext context, TimeSlot timeSlot,
          CreateFieldViewModel model) =>
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: UIHelper.size10, horizontal: UIHelper.size15),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Khung giờ',
                    style: textStyleRegular(color: Colors.grey),
                  ),
                  Text(
                    '${DateUtil().getTimeStringFromDouble(timeSlot.startTime)}-${DateUtil().getTimeStringFromDouble(timeSlot.endTime)}',
                    style: textStyleRegular(),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Giá thuê sân',
                    style: textStyleRegular(color: Colors.grey),
                  ),
                  InputPriceWidget(
                    keyword: StringUtil.formatCurrency(timeSlot.price),
                    onChangedText: (text) => model.updatePriceItem(
                        timeSlot.dayOfWeek, timeSlot.index, text),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _handleCreateField(BuildContext context, CreateFieldViewModel model) async {
    UIHelper.showProgressDialog;
    var resp = await model.createField(
        Provider.of<Ground>(context).id, 'Sân số $_number', type);
    UIHelper.hideProgressDialog;
    if (resp.isSuccess) {
      UIHelper.showSimpleDialog('Thêm sân thành công',
          onConfirmed: () => Navigator.of(context).pop());
    } else {
      UIHelper.showSimpleDialog(resp.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    UIHelper().init(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: SafeArea(
        top: false,
        child: BaseWidget<CreateFieldViewModel>(
          model: CreateFieldViewModel(
            api: Provider.of<Api>(context),
            groundServices: Provider.of<GroundServices>(context),
          ),
          onModelReady: (model) => model.changeTimeActive(4, 23.5),
          builder: (c, model, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppBarWidget(
                  centerContent: Text(
                    'Sân số $_number',
                    textAlign: TextAlign.center,
                    style: textStyleTitle(),
                  ),
                  leftContent: AppBarButtonWidget(
                    imageName: Images.BACK,
                    onTap: () => Navigator.pop(context),
                  ),
                  rightContent: InkWell(
                    onTap: () => _handleCreateField(context, model),
                    child: SizedBox(
                      width: UIHelper.size50,
                      child: Text(
                        'Thêm',
                        style: textStyleButton(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BorderBackground(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: UIHelper.size15,
                              vertical: UIHelper.size10),
                          child: ChooseFieldType(
                            onSelectedType: (type) => this.type = type,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: UIHelper.size15),
                          child: TimeSliderWidget(
                              onSelectedTime: (start, end) =>
                                  model.changeTimeActive(start, end)),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: UIHelper.size15),
                          child: Text(
                            'Khung giờ gợi ý',
                            style: textStyleRegular(),
                          ),
                        ),
                        Expanded(
                          child: DefaultTabController(
                            length: model.timeSlotMap.length,
                            child: Column(
                              children: <Widget>[
                                TabBarWidget(
                                  titles: model.timeSlotMap.keys
                                      .toList()
                                      .map((item) =>
                                          DateUtil().getDayOfWeek(item))
                                      .toList(),
                                  isScrollable: true,
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: model.timeSlotMap.values
                                        .toList()
                                        .map((timeSlots) => ListView.separated(
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (c, index) =>
                                                _buildItemTimeSlot(context,
                                                    timeSlots[index], model),
                                            separatorBuilder: (c, index) =>
                                                LineWidget(),
                                            itemCount: timeSlots.length))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
