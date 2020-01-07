import 'dart:async';
import 'package:footballground/model/device_info.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/model/header.dart';
import 'package:footballground/model/responses/base_response.dart';
import 'package:footballground/model/responses/login_response.dart';
import 'package:footballground/model/token.dart';
import 'package:footballground/model/user.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/local_storage.dart';
import 'api_config.dart';

class AuthServices {
  final Api _api;
  final LocalStorage _preferences;
  User _user;

  AuthServices({Api api, LocalStorage sharePreferences})
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

  Future<LoginResponse> loginEmail(
      String deviceId, String email, String password) async {
    var resp = await _api.loginEmail(email, password);
    if (resp.isSuccess) {
      updateUser(resp.user);
      _preferences.setToken(Token(
          deviceId: deviceId,
          token: resp.token,
          refreshToken: resp.refreshToken));
      ApiConfig.setHeader(Header(accessToken: resp.token, deviceId: deviceId));
    }
    return resp;
  }

  Future<BaseResponse> registerDevice(DeviceInfo deviceInfo) async {
    return await _api.registerDevice(deviceInfo);
  }

  Future<LoginResponse> refreshToken() async {
    var token = await _preferences.getToken();
    ApiConfig.setHeader(Header(deviceId: token.deviceId));
    if (token != null) {
      var resp = await _api.refreshToken(token.refreshToken);
      if (resp.isSuccess) {
        updateUser(resp.user);
        _preferences.setToken(Token(
            deviceId: token.deviceId,
            token: resp.token,
            refreshToken: resp.refreshToken));
        ApiConfig.setHeader(
            Header(deviceId: token.deviceId, accessToken: resp.token));
      } else {
        _preferences.clearToken();
      }
      return resp;
    }
    return LoginResponse.error('Phiên đăng nhập đã hết hạn');
  }
}
