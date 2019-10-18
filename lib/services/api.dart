import 'package:dio/dio.dart';
import 'package:footballground/models/device_info.dart';
import 'package:footballground/models/field.dart';
import 'package:footballground/models/ground.dart';
import 'package:footballground/models/responses/base_response.dart';
import 'package:footballground/models/responses/field_resp.dart';
import 'package:footballground/models/responses/ground_resp.dart';
import 'package:footballground/models/responses/login_response.dart';
import 'package:footballground/models/responses/notification_resp.dart';

import 'base_api.dart';

class Api {
  final _api = BaseApi();

  Future<LoginResponse> loginEmail(String email, String password) async {
    try {
      var response = await _api.getAuthApi('user/login',
          queryParams: FormData.from({
            'email': email,
            'password': password,
          }));
      return LoginResponse.success(response.data);
    } on DioError catch (e) {
      return LoginResponse.error(e.message);
    }
  }

  Future<BaseResponse> registerDevice(DeviceInfo deviceInfo) async {
    try {
      var resp = await _api.postApi('device-info', body: deviceInfo.toJson());
      return BaseResponse.success(resp.data);
    } on DioError catch (e) {
      return BaseResponse.error(e.message);
    }
  }

  Future<BaseResponse> register(String name, String email, String password,
      String phoneNumber, List<int> roles) async {
    try {
      // for body
      var response = await _api.postAuthApi('user/register', body: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phoneNumber,
        "roles": roles
      });
      return BaseResponse.success(response.data);
    } on DioError catch (e) {
      return BaseResponse.error(e.message);
    }
  }

  Future<BaseResponse> forgotPassword(String email) async {
    try {
      var response = await _api
          .postAuthApi('user/forgot-password', body: {"email": email});
      return BaseResponse.success(response.data);
    } on DioError catch (e) {
      return BaseResponse.error(e.message);
    }
  }

  Future<BaseResponse> changePassword(
      String email, String password, String code) async {
    try {
      var response = await _api.postAuthApi('user/change-password',
          body: {"email": email, "password": password, "code": code});
      return BaseResponse.success(response.data);
    } on DioError catch (e) {
      return BaseResponse.error(e.message);
    }
  }

  Future<LoginResponse> refreshToken(String refreshToken) async {
    try {
      var resp =
          await _api.getAuthApi('user/login/refresh-token/$refreshToken');
      return LoginResponse.success(resp.data);
    } on DioError catch (e) {
      return LoginResponse.error(e.message);
    }
  }

  Future<GroundResponse> createGround(Ground ground) async {
    try {
      var resp =
          await _api.postApi('ground/create', body: ground.createGroundJson());
      return GroundResponse.success(resp.data);
    } on DioError catch (e) {
      return GroundResponse.error(e.message);
    }
  }

  Future<GroundResponse> updateGround(Ground ground) async {
    try {
      var resp = await _api.putApi('ground/update', body: ground.toJson());
      return GroundResponse.success(resp.data);
    } on DioError catch (e) {
      return GroundResponse.error(e.message);
    }
  }

  Future<FieldResponse> createField(int groundId, Field field) async {
    try {
      var resp = await _api.postApi('ground/$groundId/field',
          body: field.toCreateJson());
      return FieldResponse.success(resp.data);
    } on DioError catch (e) {
      return FieldResponse.error(e.message);
    }
  }

  Future<NotificationResponse> getNotifications() async {
    try {
      var resp = await _api.getApi("user/notification");
      return NotificationResponse.success(resp.data);
    } on DioError catch (e) {
      return NotificationResponse.error(e.message);
    }
  }
}
