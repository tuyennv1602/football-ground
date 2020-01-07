import 'package:footballground/util/constants.dart';

class BaseResponse {
  String _errorMessage;
  String _statusCode;
  bool _success;

  BaseResponse({bool success, String errorMessage})
      : _errorMessage = errorMessage,
        _success = success;

  BaseResponse.success(Map<String, dynamic> json) {
    _errorMessage = json['error_messge'];
    _statusCode = json['status_code'];
    _success = json['success'];
  }

  BaseResponse.error(String message) {
    this._success = false;
    this._errorMessage = message;
  }

  bool get isSuccess => _success && _statusCode == Constants.CODE_OK;

  String get errorMessage {
    if (_statusCode == Constants.CODE_UNAUTHORIZED) {
      return 'Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại';
    }
    if (_statusCode == Constants.CODE_NOT_ACCEPTABLE) {
      return 'Tài khoản chưa được kích hoạt! Một mã xác thực gồm 6 ký tự sẽ được gửi đến số điện thoại của bạn. Vui lòng nhập mã xác thực để kích hoạt tài khoản';
    }
    return _errorMessage;
  }

  get statusCode => _statusCode;
}
