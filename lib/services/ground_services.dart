import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:footballground/models/ground.dart';
import 'package:footballground/models/responses/ground_resp.dart';
import 'package:footballground/services/api.dart';

class GroundServices {
  final Api _api;
  Ground _currentGround;

  GroundServices({@required Api api}) : _api = api;

  StreamController<Ground> _groundController = StreamController<Ground>();

  Stream<Ground> get ground => _groundController.stream;

  Future<GroundResponse> getGroundDetail(int groundId) async {
    return null;
  }

  setGround(Ground ground) {
    _currentGround = ground;
    _groundController.add(_currentGround);
  }
}
