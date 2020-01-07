import 'package:flutter/cupertino.dart';
import 'package:footballground/model/responses/login_response.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/auth_services.dart';
import 'package:footballground/services/ground_services.dart';
import 'package:footballground/viewmodel/base_viewmodel.dart';

class TicketViewModel extends BaseViewModel {
  Api _api;

  TicketViewModel({@required Api api}) : _api = api;
}
