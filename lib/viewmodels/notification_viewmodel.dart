import 'package:flutter/material.dart';
import 'package:footballground/models/notification.dart' as noti;
import 'package:footballground/models/responses/notification_resp.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/viewmodels/base_viewmodel.dart';

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