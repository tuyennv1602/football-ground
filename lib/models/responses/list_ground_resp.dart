import 'package:footballground/models/ground.dart';
import 'package:footballground/models/responses/base_response.dart';

class ListGroundResponse extends BaseResponse {
  List<Ground> grounds;

  ListGroundResponse.success(Map<String, dynamic> json) : super.success(json) {
    if (json['object'] != null) {
      grounds = new List<Ground>();
      json['object'].forEach((v) {
        var ground = new Ground.fromJson(v);
        grounds.add(ground);
      });
    }
  }

  ListGroundResponse.error(String message) : super.error(message);

  Ground get getGround => grounds != null ? grounds[0] : null;
}
