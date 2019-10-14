import 'package:flutter/cupertino.dart';
import 'package:footballground/models/responses/list_ground_resp.dart';
import 'package:footballground/models/responses/login_response.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/auth_services.dart';
import 'package:footballground/viewmodels/base_viewmodel.dart';

class GroundViewModel extends BaseViewModel {
  final AuthServices _authServices;
  final Api _api;

  GroundViewModel({@required Api api, @required AuthServices authServices})
      : _authServices = authServices,
        _api = api;

  Future<LoginResponse> refreshToken() async {
    setBusy(true);
    var resp = await _authServices.refreshToken();
    if (resp.isSuccess) {
      await getGround();
    }
    setBusy(false);
    return resp;
  }

  Future<ListGroundResponse> getGround() async {
    var resp = await _api.getGrounds();
    if (resp.isSuccess && resp.grounds.length > 0) {
      _authServices.updateUserGround(resp.grounds[0]);
    }
    return resp;
  }
}
