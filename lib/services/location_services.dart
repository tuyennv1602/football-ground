import 'package:flutter/services.dart';
import 'package:footballground/http.dart';
import 'package:footballground/model/address_info.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoder/geocoder.dart';

class LocationServices {
  static const GOOGLE_API = 'AIzaSyBGPrLiAyIJhRwmvVk2J9xOk6nG6LS8AAI';

  Future<Position> getCurrentLocation() async {
    try {
      return await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } on PlatformException catch (e) {
      print(e);
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler().requestPermissions([
        PermissionGroup.location,
        PermissionGroup.locationAlways,
        PermissionGroup.locationWhenInUse
      ]);
      if (permissions[PermissionGroup.location] == PermissionStatus.granted &&
          permissions[PermissionGroup.locationAlways] ==
              PermissionStatus.granted &&
          permissions[PermissionGroup.locationWhenInUse] ==
              PermissionStatus.granted) {
        return await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }
      return Future.value(null);
    }
  }

  Future<Address> findAddressFromCoordinate(Coordinates coordinates) async {
    try {
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      return addresses.first;
    } on PlatformException catch (e) {
      print(e);
      return null;
    }
  }

  Future<AddressInfo> getAddressInfoFromCoordinate(LatLng latLng) async {
    try {
      var resp = await dio.get(
          'https://maps.googleapis.com/maps/api/geocode/json?key=$GOOGLE_API&language=vi&region=vi&result_type=sublocality&latlng=${latLng.latitude},${latLng.longitude}');
      var result = resp.data;
      if (result['status'] == 'OK' && result['results'].length > 0) {
        var addressComponents = result['results'][0]['address_components'];
        return AddressInfo(
            wardName: addressComponents[0]['short_name'],
            districtName: addressComponents[1]['short_name'],
            provinceName: addressComponents[2]['short_name']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
