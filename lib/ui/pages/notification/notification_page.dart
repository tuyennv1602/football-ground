
import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/widgets/app_bar_button.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:footballground/ui/widgets/empty_widget.dart';
import 'package:footballground/ui/widgets/loading_widget.dart';
import 'package:footballground/utils/ui_helper.dart';
import 'package:footballground/models/notification.dart' as noti;
import 'package:footballground/viewmodels/notification_viewmodel.dart';
import 'package:provider/provider.dart';

import '../base_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationState();
  }
}

class NotificationState extends State<NotificationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget _buildItemNotification(
      BuildContext context, noti.Notification notification) =>
      Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIHelper.size15),
        ),
        margin: EdgeInsets.symmetric(horizontal: UIHelper.size15),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: UIHelper.size10, vertical: UIHelper.size10),
          child: Row(
            children: <Widget>[
              Container(
                width: UIHelper.size10,
                height: UIHelper.size10,
                margin: EdgeInsets.only(
                    left: UIHelper.size5, right: UIHelper.size15),
                decoration: BoxDecoration(
                    color: PRIMARY,
                    borderRadius: BorderRadius.circular(UIHelper.size5),
                    boxShadow: [
                      BoxShadow(
                          color: SHADOW_GREEN,
                          offset: Offset(0, 0),
                          blurRadius: UIHelper.size5,
                          spreadRadius: UIHelper.size5)
                    ]),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(notification.getCreateTime,
                        style: textStyleRegularBody(color: Colors.grey)),
                    Text(
                      notification.title,
                      style: textStyleRegularTitle(),
                    ),
                    Text(
                      notification.body,
                      maxLines: 3,
                      style: textStyleRegularBody(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UIHelper().init(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            centerContent: Text(
              "Thông báo",
              textAlign: TextAlign.center,
              style: textStyleTitle(),
            ),
            rightContent: AppBarButtonWidget(
              imageName: Images.CLEAR,
              onTap: () {},
            ),
          ),
          Expanded(
            child: BorderBackground(
              child: BaseWidget<NotificationViewModel>(
                model: NotificationViewModel(api: Provider.of(context)),
                onModelReady: (model) => model.getNotifications(),
                builder: (c, model, child) {
                  if (model.busy) {
                    return LoadingWidget();
                  }
                  return model.notifications.length > 0
                      ? ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding:
                      EdgeInsets.symmetric(vertical: UIHelper.size10),
                      itemBuilder: (c, index) => _buildItemNotification(
                          context, model.notifications[index]),
                      separatorBuilder: (c, index) =>
                          SizedBox(height: UIHelper.size15),
                      itemCount: model.notifications.length)
                      : EmptyWidget(message: 'Không có thông báo nào');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
