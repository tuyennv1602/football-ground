import 'dart:async';
import 'package:footballground/model/field.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/model/responses/ground_resp.dart';

class GroundServices {
  Ground _currentGround;

  StreamController<Ground> _groundController = StreamController<Ground>();

  Stream<Ground> get ground => _groundController.stream;

  Future<GroundResponse> getGroundDetail(int groundId) async {
    return null;
  }

  setGround(Ground ground) {
    _currentGround = ground;
    _groundController.add(_currentGround);
  }

  addField(Field field) {
    field.timeSlots.clear();
    if (_currentGround.fields == null) {
      _currentGround.fields = List<Field>();
    }
    _currentGround.fields.add(field);
    _currentGround.countField = _currentGround.countField + 1;
    _groundController.add(_currentGround);
  }
}
