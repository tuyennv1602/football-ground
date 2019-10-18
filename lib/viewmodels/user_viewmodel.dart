import 'package:flutter/cupertino.dart';
import 'package:footballground/services/ground_services.dart';
import 'package:footballground/services/share_preferences.dart';

import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  SharePreferences _preferences;
  GroundServices _groundServices;

  UserViewModel(
      {@required SharePreferences sharePreferences,
      @required GroundServices groundServices})
      : _preferences = sharePreferences,
        _groundServices = groundServices;

  Future<bool> logout() async {
    setBusy(true);
    var _token = await _preferences.clearToken();
    if (_token) {
      _groundServices.setGround(null);
    }
    setBusy(false);
    return _token;
  }
}
