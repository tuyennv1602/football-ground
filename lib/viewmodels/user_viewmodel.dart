import 'package:flutter/cupertino.dart';
import 'package:footballground/services/share_preferences.dart';

import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  SharePreferences _preferences;

  UserViewModel({@required SharePreferences sharePreferences})
      : _preferences = sharePreferences;

  Future<bool> logout() async {
    setBusy(true);
    var _token = await _preferences.clearToken();
    var _lastTeam = await _preferences.clearLastTeam();
    setBusy(false);
    return _token && _lastTeam;
  }
}
