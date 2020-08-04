import 'dart:async';

import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vote4hk_mobile/blocs/app_bloc.dart';
import 'package:vote4hk_mobile/blocs/map_bloc.dart';
import 'package:vote4hk_mobile/i18n/app_localizations.dart';
import 'package:vote4hk_mobile/models/case_location.dart';
import 'package:vote4hk_mobile/models/map_marker.dart';
import 'package:vote4hk_mobile/models/user_location.dart';

// https://github.com/alfonsocejudo/fluster_demo/blob/master/lib/main.dart

class HighRiskPage extends StatefulWidget {
  @override
  State<HighRiskPage> createState() => HighRiskPageState();
}

class HighRiskPageState extends State<HighRiskPage> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor markerIcon;
  MapBloc _bloc;
  double _currentZoom = 12.0;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.3672, 114.0618),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/pin.png')
        .then((value) {
      markerIcon = value;
    });
  }

  @override
  void didChangeDependencies() {
    _bloc = MapBloc();

    super.didChangeDependencies();
  }

  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).get('site.title')),
      ),
      body: StreamBuilder<Map<MarkerId, Marker>>(
          stream: _bloc.markers,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraIdle: _onCameraIdle,
              onCameraMove: _onCameraMove,
              markers: (snapshot.data != null)
                  ? Set.of(snapshot.data.values)
                  : Set(),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  // May be called as often as every frame, so just track the last zoom value.
  void _onCameraMove(CameraPosition cameraPosition) {
    _bloc.updateUserLocation(UserLocationRequest(
      type: UserLocationRequestType.Add,
      location: UserLocation(
        addressEn: "test",
        addressZh: "test_zh",
        lat: cameraPosition.target.latitude,
        lng: cameraPosition.target.longitude
      )
    ));
  }

  void _onCameraIdle() {
    // _bloc.setCameraZoom(_currentZoom);
  }
}
