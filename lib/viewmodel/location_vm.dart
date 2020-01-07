import 'package:flutter/material.dart';
import 'package:footballground/model/address_info.dart';
import 'package:footballground/services/location_services.dart';
import 'package:footballground/services/sqlite_service.dart';
import 'package:footballground/viewmodel/base_viewmodel.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationViewModel extends BaseViewModel {
  LatLng currentPosition = LatLng(21.026099, 105.833273);
  Address locationDetail;
  SQLiteServices _sqLiteServices;

  LocationViewModel({@required SQLiteServices sqLiteServices})
      : _sqLiteServices = sqLiteServices;

  Future<Position> getMyLocation() async {
    setBusy(true);
    var position = await LocationServices().getCurrentLocation();
    changePosition(LatLng(position.latitude, position.longitude));
    setBusy(false);
    return position;
  }

  Future<void> getLocationDetail() async {
    setBusy(true);
    var address = await LocationServices().findAddressFromCoordinate(
        Coordinates(currentPosition.latitude, currentPosition.longitude));
    if (address != null) {
      locationDetail = address;
    }
    setBusy(false);
  }

  changePosition(LatLng newPosition) {
    this.currentPosition = newPosition;
    notifyListeners();
  }

  Future<List<AddressInfo>> getSuggestRegions() async {
    var addressInfo =
        await LocationServices().getAddressInfoFromCoordinate(currentPosition);
    if (addressInfo == null) return Future.value(null);
    return await _sqLiteServices.getAddressInfos(addressInfo.provinceName,
        addressInfo.districtName, addressInfo.wardName);
  }
}
