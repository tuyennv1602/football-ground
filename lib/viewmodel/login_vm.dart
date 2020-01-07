import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:footballground/model/device_info.dart';
import 'package:footballground/model/header.dart';
import 'package:footballground/model/responses/base_response.dart';
import 'package:footballground/model/verify_arg.dart';
import 'package:footballground/router/navigation.dart';
import 'package:footballground/router/paths.dart';
import 'package:footballground/services/api_config.dart';
import 'package:footballground/services/auth_services.dart';
import 'package:footballground/util/constants.dart';
import 'package:footballground/view/ui_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  final AuthServices _authServices;
  DeviceInfo deviceInfo;

  LoginViewModel({@required AuthServices authServices})
      : _authServices = authServices;

  Future<void> setupDeviceInfo() async {
    var resp = await getDeviceInfo();
    this.deviceInfo = resp;
    ApiConfig.setHeader(Header(deviceId: deviceInfo.deviceId));
  }

  Future<void> loginEmail(String email, String password) async {
    UIHelper.showProgressDialog;
    var resp =
        await _authServices.loginEmail(deviceInfo.deviceId, email, password);
    if (resp.isSuccess) {
      var _registerDeviceResp = await registerDevice();
      UIHelper.hideProgressDialog;
      if (_registerDeviceResp.isSuccess) {
        Navigation.instance.navigateAndRemove(HOME);
      } else {
        UIHelper.showSimpleDialog(_registerDeviceResp.errorMessage);
      }
    } else {
      UIHelper.hideProgressDialog;
      if (resp.statusCode == Constants.CODE_NOT_ACCEPTABLE) {
        UIHelper.showConfirmDialog(resp.errorMessage,
            onConfirmed: () =>
                verifyPhoneNumber(resp.user.id, resp.user.phone));
      } else {
        UIHelper.showSimpleDialog(resp.errorMessage);
      }
    }
  }

  Future<DeviceInfo> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String firebaseToken = await FirebaseMessaging().getToken();
    String deviceId;
    String os;
    String version;
    String deviceName;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
      os = 'ANDROID';
      deviceName = androidInfo.model;
      version = androidInfo.version.release;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
      os = 'IOS';
      deviceName = iosInfo.name;
      version = iosInfo.systemVersion;
    }
    return DeviceInfo(
        deviceId: deviceId,
        firebaseToken: firebaseToken,
        os: os,
        deviceVer: version,
        deviceName: deviceName);
  }

  Future<BaseResponse> registerDevice() async {
    setBusy(true);
    var resp = await _authServices.registerDevice(deviceInfo);
    setBusy(false);
    return resp;
  }

  Future<void> verifyPhoneNumber(int userId, String phoneNumber) async {
    UIHelper.showProgressDialog;
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      UIHelper.hideProgressDialog;
      print('verify completely');
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      UIHelper.hideProgressDialog;
      UIHelper.showSimpleDialog(
          'Gửi mã xác thực lỗi: ${authException.message}');
    };
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      UIHelper.hideProgressDialog;
      print('code sent: ' + verificationId);
      Navigation.instance.navigateTo(VERIFY_OTP,
          arguments: VerifyArgument(
              userId: userId,
              phoneNumber: phoneNumber,
              verificationId: verificationId));
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      UIHelper.hideProgressDialog;
      print('Gửi mã xác thực lỗi: Timeout!');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(minutes: 1),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<void> loginFacebook() async {
    final result = await FacebookLogin().logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('canceled');
        break;
      case FacebookLoginStatus.error:
        UIHelper.showSimpleDialog(result.errorMessage);
        break;
    }
  }

  Future<void> loginGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      UIHelper.showProgressDialog;
      var account = await _googleSignIn.signIn();
      var token = (await account.authentication).accessToken;
      UIHelper.hideProgressDialog;
      print(token);
    } catch (error) {
      UIHelper.showSimpleDialog(error.toString());
    }
  }
}
