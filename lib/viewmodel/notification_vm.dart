import 'package:flutter/material.dart';
import 'package:footballground/model/notification.dart' as noti;
import 'package:footballground/model/responses/notification_resp.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/viewmodel/base_viewmodel.dart';

class NotificationViewModel extends BaseViewModel{
  Api _api;
  List<noti.Notification> notifications = [];

  NotificationViewModel({@required Api api}) : _api = api;

  Future<NotificationResponse> getNotifications() async {
    setBusy(true);
    var resp = await _api.getNotifications();
    if (resp.isSuccess) {
      notifications = resp.notifications;
    }
    setBusy(false);
    return resp;
  }
}