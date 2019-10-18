import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/pages/base_widget.dart';
import 'package:footballground/ui/routes/routes.dart';
import 'package:footballground/ui/widgets/app_bar_button.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:footballground/ui/widgets/search_widget.dart';
import 'package:footballground/utils/ui_helper.dart';
import 'package:footballground/viewmodels/location_viewmodel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocationState();
  }
}

class LocationState extends State<LocationPage> {
  static final CameraPosition _kPlaceInit = CameraPosition(
    target: LatLng(21.026099, 105.833273),
    zoom: 10,
  );

  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor _myMarker;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
                size: Platform.isAndroid
                    ? Size(UIHelper.size50, UIHelper.size50)
                    : Size(UIHelper.size20, UIHelper.size20),
                devicePixelRatio: 2),
            Images.MARKER)
        .then((value) {
      _myMarker = value;
    });
  }

  Future<void> _updateMyLocation(LocationViewModel model) async {
    await model.getMyLocation();
    await model.getLocationDetail();
    _animateToPosition(model.currentPosition);
  }

  Future<void> _animateToPosition(LatLng target) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 16),
      ),
    );
  }

  Future<void> _navigateToCreatePage(
      BuildContext context, LocationViewModel model) async {
    UIHelper.showProgressDialog;
    var resp = await model.getSuggestRegions();
    UIHelper.hideProgressDialog;
    Routes.routeToCreateGround(context, model.locationDetail, resp[0] ?? null);
  }

  @override
  Widget build(BuildContext context) {
    UIHelper().init(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            AppBarWidget(
              centerContent: Text(
                'Vị trí sân bóng',
                textAlign: TextAlign.center,
                style: textStyleTitle(),
              ),
              leftContent: AppBarButtonWidget(
                imageName: Images.BACK,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: BorderBackground(
                child: BaseWidget<LocationViewModel>(
                  model: LocationViewModel(sqLiteServices: Provider.of(context)),
                  onModelReady: (model) => model.getMyLocation(),
                  builder: (c, model, child) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              GoogleMap(
                                myLocationButtonEnabled: false,
                                mapType: MapType.normal,
                                initialCameraPosition: _kPlaceInit,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                  _updateMyLocation(model);
                                },
                                markers: [
                                  Marker(
                                    markerId: MarkerId('myMarker'),
                                    position: model.currentPosition,
                                    icon: _myMarker,
                                    draggable: true,
                                    onDragEnd: (position) async {
                                      model.changePosition(position);
                                      await model.getLocationDetail();
                                      _animateToPosition(position);
                                    },
                                  ),
                                ].toSet(),
                              ),
                              SearchWidget(
//                        keyword: model.key,
                                hintText: 'Tìm kiếm địa điểm',
                                isLoading: false,
                                onChangedText: (text) {},
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () => _updateMyLocation(model),
                                  child: Padding(
                                    padding: EdgeInsets.all(UIHelper.size5),
                                    child: Image.asset(
                                      Images.MY_LOCATION,
                                      width: UIHelper.size(60),
                                      height: UIHelper.size(60),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => _navigateToCreatePage(context, model),
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: UIHelper.size10),
                            height: UIHelper.size45,
                            color: PRIMARY,
                            child: model.busy
                                ? Center(
                                    child: Image.asset(Images.LOADING),
                                  )
                                : Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          model.locationDetail != null
                                              ? model.locationDetail.addressLine
                                              : '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyleRegular(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Image.asset(
                                        Images.NEXT,
                                        width: UIHelper.size40,
                                        height: UIHelper.size20,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
