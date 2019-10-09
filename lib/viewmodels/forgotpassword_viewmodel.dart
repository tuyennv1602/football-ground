import 'package:flutter/material.dart';
import 'package:footballground/models/responses/base-response.dart';
import 'package:footballground/services/api.dart';

import 'base_viewmodel.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  Api _api;
  bool isChangePassword = false;

  ForgotPasswordViewModel({@required Api api}) : this._api = api;

  Future<BaseResponse> forgotPassword(String email) async {
    setBusy(true);
    var resp = await _api.forgotPassword(email);
    if (resp.isSuccess) {
      isChangePassword = true;
    }
    setBusy(false);
    return resp;
  }

  Future<BaseResponse> changePassword(
      String email, String password, String code) async {
    setBusy(true);
    var resp = await _api.changePassword(email, password, code);
    setBusy(false);
    return resp;
  }
}
