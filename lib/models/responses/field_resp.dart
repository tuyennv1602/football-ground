import 'package:footballground/models/field.dart';
import 'package:footballground/models/responses/base_response.dart';

class FieldResponse extends BaseResponse {
  Field field;

  FieldResponse.success(Map<String, dynamic> json) : super.success(json) {
    if (json['object'] != null) {
      field = Field.fromJson(json['object']);
    }
  }

  FieldResponse.error(String message) : super.error(message);
}
