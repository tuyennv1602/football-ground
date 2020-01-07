import 'package:flutter/material.dart';
import 'package:footballground/model/responses/login_response.dart';
import 'package:footballground/router/navigation.dart';
import 'package:footballground/router/paths.dart';
import 'package:footballground/services/auth_services.dart';
import 'package:footballground/services/ground_services.dart';
import 'package:footballground/view/ui_helper.dart';
import 'package:footballground/viewmodel/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final AuthServices _authServices;
  final GroundServices _groundServices;

  HomeViewModel(
      {@required AuthServices authServices,
      @required GroundServices groundServices})
      : _authServices = authServices,
        _groundServices = groundServices;

  Future<LoginResponse> refreshToken() async {
    setBusy(true);
    var resp = await _authServices.refreshToken();
    if (resp.isSuccess) {
      var _grounds = resp.user.grounds;
      if (_grounds != null && _grounds.length > 0)
        _groundServices.setGround(_grounds[0]);
    } else {
      UIHelper.showSimpleDialog(resp.errorMessage,
          onConfirmed: () => Navigation.instance.navigateAndRemove(LOGIN));
    }
    setBusy(false);
    return resp;
  }
}
