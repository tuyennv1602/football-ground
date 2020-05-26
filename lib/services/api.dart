import 'package:dio/dio.dart';
import 'package:footballground/model/device_info.dart';
import 'package:footballground/model/field.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/model/responses/base_response.dart';
import 'package:footballground/model/responses/field_resp.dart';
import 'package:footballground/model/responses/ground_resp.dart';
import 'package:footballground/model/responses/login_response.dart';
import 'package:footballground/model/responses/notification_resp.dart';

import 'api_config.dart';

class Api {
  final _api = ApiConfig();

  Future<LoginResponse> loginEmail(String email, String password) async {
    try {
//      var response = await _api.getApi('user/login', queryParams: {
//        'email': email,
//        'password': password,
//      });
      var response = await _api.getApi(
          'http://192.168.1.173:8088/user/login?email=hunghovan288@gmail.com&password=Hung0972522128');
//          'http://192.168.1.2:8088/user/login?email=hunghovan288@gmail.com&password=Hung0972522128');
      return LoginResponse.success(response.data);
    } on DioError catch (e) {
      return LoginResponse.error(e.message);
    }
  }

  Future<BaseResponse> registerDevice(DeviceInfo deviceInfo) async {
//    DeviceInfo _deviceInfor = DeviceInfo(
//        deviceId: '5e57eb18c66f4c17',
//        deviceName: 'SM-A705F',
//        deviceVer: '13.2.2',
//        firebaseToken:
//            'cd-BK5B-EmM:APA91bEVcoT9IRH6JUw67KLzpoq6nKZpj73ophIQUUOpPPtPGbYuYDYk_ozFSKPUVMf1N_qMdwDOh_98vB9_5oBe1C2Ib1AG9VTiwwePm_feZdy9Hd7_P7-7GKqgIhLebPfiIOhxK_Z7',
//    os: 'ANDROID');
    try {
      var resp = await _api.postApi('device-info', body: deviceInfo.toJson());
//      var resp = await _api.postApi('device-info', body: _deviceInfor.toJson());
      return BaseResponse.success(resp.data);
    } on DioError catch (e) {
      return BaseResponse.error(e.message);
    }
  }

  Future<LoginResponse> register(String name, String email, String password,
      String phoneNumber, List<int> roles) async {
    try {
      var response = await _api.postApi('user/register', body: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phoneNumber,
        "roles": roles
      });
      return LoginResponse.success(response.data);
    } on DioError catch (e) {
      return LoginResponse.error(e.message);
    }
  }

  Future<BaseResponse> forgotPassword(String email) async {
    try {
      var response =
          await _api.postApi('user/forgot-password', body: {"email": email});
      return BaseResponse.success(response.data);
    } on DioError catch (e) {
      return BaseResponse.error(e.message);
    }
  }

  Future<BaseResponse> changePassword(
      String email, String password, String code) async {
    try {
      var response = await _api.postApi('user/change-password',
          body: {"email": email, "password": password, "code": code});
      return BaseResponse.success(response.data);
    } on DioError catch (e) {
      return BaseResponse.error(e.message);
    }
  }

  Future<LoginResponse> refreshToken(String refreshToken) async {
    try {
      var resp = await _api.getApi('user/login/refresh-token/$refreshToken');
      return LoginResponse.success(resp.data);
    } on DioError catch (e) {
      return LoginResponse.error(e.message);
    }
  }

  Future<BaseResponse> activeUser(
      int userId, String phoneNumber, String idToken) async {
    try {
      var resp = await _api.putApi('user/active',
          body: {"user_id": userId, "phone": phoneNumber, "token_id": idToken});
      return BaseResponse.success(resp.data);
    } on DioError catch (e) {
      return BaseResponse.error(e.message);
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
