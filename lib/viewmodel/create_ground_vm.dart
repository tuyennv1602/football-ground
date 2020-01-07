import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/model/responses/ground_resp.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/firebase_services.dart';
import 'package:footballground/services/ground_services.dart';
import 'package:footballground/viewmodel/base_viewmodel.dart';

class CreateGroundViewModel extends BaseViewModel {
  Api _api;
  GroundServices _groundServices;
  File image;

  CreateGroundViewModel(
      {@required Api api, @required GroundServices groundServices})
      : _api = api,
        _groundServices = groundServices;

  void setImage(File image) {
    this.image = image;
    notifyListeners();
  }

  Future<GroundResponse> createGround(int userId, Ground ground) async {
    setBusy(true);
    var resp = await _api.createGround(ground);
    if (resp.isSuccess) {
      var _ground = resp.ground;
      if (image != null) {
        var _imageLink = await _uploadImage(userId, _ground.name);
        if (_imageLink != null) {
          // upload image success and update ground info
          print(_imageLink);
          _ground.avatar = _imageLink;
          await _api.updateGround(_ground);
        }
      }
      _groundServices.setGround(_ground);
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
