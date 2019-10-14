import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:footballground/models/ground.dart';
import 'package:footballground/models/responses/ground_resp.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/firebase_services.dart';
import 'package:footballground/viewmodels/base_viewmodel.dart';

class CreateGroundViewModel extends BaseViewModel {
  Api _api;
  File image;

  CreateGroundViewModel({@required Api api}) : _api = api;

  void setImage(File image) {
    this.image = image;
    notifyListeners();
  }

  Future<GroundResponse> createGround(int userId, Ground ground) async {
    setBusy(true);
    var resp = await _api.createGround(ground);
    if (resp.isSuccess && image != null) {
      var _ground = resp.ground;
      var _imageLink = await _uploadImage(userId, _ground.name);
      if (_imageLink != null) {
        // upload image success and update ground info
        print(_imageLink);
        _ground.avatar = _imageLink;
        await _api.updateGround(_ground);
      }
    }
    setBusy(false);
    return resp;
  }

  Future<String> _uploadImage(int managerId, String teamName) async {
    if (image == null) return null;
    var name = '$managerId-${teamName.trim().replaceAll(" ", "-")}';
    return FirebaseServices().uploadImage(image, 'ground', name);
  }
}
