import 'package:flutter/material.dart';
import 'package:footballground/models/address_info.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/pages/base_widget.dart';
import 'package:footballground/ui/widgets/app_bar_button.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:footballground/utils/ui_helper.dart';
import 'package:footballground/viewmodels/region_viewmodel.dart';
import 'package:provider/provider.dart';

class RegionPage extends StatelessWidget {
  final List<AddressInfo> _addressInfos;

  RegionPage({@required List<AddressInfo> addressInfos})
      : _addressInfos = addressInfos;

  @override
  Widget build(BuildContext context) {
    UIHelper().init(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            centerContent: Text(
              'Chọn vùng',
              textAlign: TextAlign.center,
              style: textStyleTitle(),
            ),
            leftContent: AppBarButtonWidget(
              imageName: Images.BACK,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          Expanded(
            child: BorderBackground(
              child: BaseWidget<RegionViewModel>(
                model: RegionViewModel(
                  sqLiteServices: Provider.of(context),
                ),
                builder: (c, model, child) {
                  return Text(_addressInfos.length.toString());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
