import 'package:flutter/cupertino.dart';
import 'package:footballground/models/responses/login_response.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/auth_services.dart';
import 'package:footballground/services/ground_services.dart';
import 'package:footballground/viewmodels/base_viewmodel.dart';

class GroundViewModel extends BaseViewModel {
  final AuthServices _authServices;
  final GroundServices _groundServices;
  final Api _api;

  GroundViewModel(
      {@required Api api,
      @required AuthServices authServices,
      @required GroundServices groundServices})
      : _authServices = authServices,
        _api = api,
        _groundServices = groundServices;

  Future<LoginResponse> refreshToken() async {
    setBusy(true);
    var resp = await _authServices.refreshToken();
    if (resp.isSuccess) {
      var _grounds = resp.user.grounds;
      if (_grounds != null && _grounds.length > 0)
        _groundServices.setGround(_grounds[0]);
    }
    setBusy(false);
    return resp;
  }
}
