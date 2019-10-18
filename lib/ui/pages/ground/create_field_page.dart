import 'package:flutter/material.dart';
import 'package:footballground/models/ground.dart';
import 'package:footballground/models/time_slot.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/pages/base_widget.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/app_bar_button.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:footballground/ui/widgets/choose_field_type.dart';
import 'package:footballground/ui/widgets/input_price_widget.dart';
import 'package:footballground/ui/widgets/line_widget.dart';
import 'package:footballground/ui/widgets/tabbar_widget.dart';
import 'package:footballground/ui/widgets/time_slider_widget.dart';
import 'package:footballground/utils/constants.dart';
import 'package:footballground/utils/date_util.dart';
import 'package:footballground/utils/string_util.dart';
import 'package:footballground/utils/ui_helper.dart';
import 'package:footballground/viewmodels/create_field_viewmodel.dart';
import 'package:provider/provider.dart';

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
                    style: textStyleRegularTitle(),
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
          onTap: () => Navigator.of(context).pop());
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
            api: Provider.of(context),
            groundServices: Provider.of(context),
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
                        UIHelper.verticalSpaceMedium,
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: UIHelper.size15),
                          child: ChooseFieldTypeWidget(
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
                            style: textStyleRegularTitle(),
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
