import 'package:footballground/utils/constants.dart';

class BaseResponse {
  String errorMessage;
  String statusCode;
  bool success;

  BaseResponse({this.success, this.errorMessage});

  BaseResponse.success(Map<String, dynamic> json) {
    errorMessage = json['error_messge'];
    statusCode = json['status_code'];
    success = json['success'];
  }

  BaseResponse.error(String message) {
    this.success = false;
    this.errorMessage = message;
  }

  bool get isSuccess => statusCode == Constants.CODE_OK;
}
