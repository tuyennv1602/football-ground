import 'dart:async';
import 'package:footballground/models/device_info.dart';
import 'package:footballground/models/ground.dart';
import 'package:footballground/models/headers.dart';
import 'package:footballground/models/responses/base_response.dart';
import 'package:footballground/models/responses/login_response.dart';
import 'package:footballground/models/token.dart';
import 'package:footballground/models/user.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/share_preferences.dart';
import 'base_api.dart';

class AuthServices {
  final Api _api;
  final SharePreferences _preferences;
  User _user;

  AuthServices({Api api, SharePreferences sharePreferences})
      : _api = api,
        _preferences = sharePreferences;

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  updateUser(User user) {
    _user = user;
    _userController.add(user);
  }

  updateUserGround(Ground ground) {
    if (_user.grounds != null) {
      _user.grounds.add(ground);
    } else {
      _user.grounds = [ground];
    }
    _userController.add(_user);
  }

  Future<LoginResponse> loginEmail(String email, String password) async {
    var resp = await _api.loginEmail(email, password);
    if (resp.isSuccess) {
      updateUser(resp.user);
      _preferences
          .setToken(Token(token: resp.token, refreshToken: resp.refreshToken));
      BaseApi.setHeader(Headers(accessToken: resp.token));
    }
    return resp;
  }

  Future<BaseResponse> registerDevice(DeviceInfo deviceInfo) async {
    return await _api.registerDevice(deviceInfo);
  }

  Future<LoginResponse> refreshToken() async {
    var token = await _preferences.getToken();
    if (token != null) {
      var resp = await _api.refreshToken(token.refreshToken);
      if (resp.isSuccess) {
        updateUser(resp.user);
        _preferences.setToken(
            Token(token: resp.token, refreshToken: resp.refreshToken));
        BaseApi.setHeader(Headers(accessToken: resp.token));
      } else {
        _preferences.clearToken();
      }
      return resp;
    }
    return LoginResponse.error('Phiên đăng nhập đã hết hạn');
  }
}
