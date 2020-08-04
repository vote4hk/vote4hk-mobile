import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vote4hk_mobile/api/api.dart';
import 'package:fluster/fluster.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as images;
import 'package:vote4hk_mobile/models/case_location.dart';
import 'package:vote4hk_mobile/models/map_marker.dart';
import 'package:vote4hk_mobile/models/user_location.dart';

enum UserLocationRequestType {
  Add,
  Set,
  Remove,
}

class UserLocationRequest {
  final UserLocationRequestType type;

  final UserLocation location;

  UserLocationRequest({this.type, this.location});
}

// Reference: https://github.com/alfonsocejudo/fluster_demo/blob/master/lib/main_bloc.dart
class MapBloc {
  static const minZoom = 10;

  static const maxZoom = 21;

  BitmapDescriptor _cachedIcon;

  // Current pool of available media that can be displayed on the map.
  final Map<String, MapMarker> _mediaPool;

  final List<UserLocation> _userLocations;

  final List<MapMarker> _allCaseMarkers;

  /// Markers currently displayed on the map.
  final _markerController = StreamController<Map<MarkerId, Marker>>.broadcast();

  /// Camera zoom level after end of user gestures / movement.
  final _cameraZoomController = StreamController<double>.broadcast();

  final _userLocationController =
      StreamController<UserLocationRequest>.broadcast();

  /// Outputs.
  Stream<Map<MarkerId, Marker>> get markers => _markerController.stream;
  Stream<double> get cameraZoom => _cameraZoomController.stream;
  Stream<UserLocationRequest> get userLocationRequest =>
      _userLocationController.stream;

  /// Inputs.
  Function(Map<MarkerId, Marker>) get addMarkers => _markerController.sink.add;
  Function(double) get setCameraZoom => _cameraZoomController.sink.add;
  Function(UserLocationRequest) get updateUserLocation =>
      _userLocationController.sink.add;

  /// Internal listener.
  StreamSubscription _cameraZoomSubscription;
  StreamSubscription _userLocationRequestSubscription;

  /// Keep track of the current Google Maps zoom level.
  var _currentZoom = 12; // As per _initialCameraPosition in main.dart

  MapBloc()
      : _mediaPool = LinkedHashMap<String, MapMarker>(),
        _userLocations = List<UserLocation>(),
        _allCaseMarkers = List<MapMarker>() {
    _loadUserLocations();
    _buildMediaPool();

    _userLocationRequestSubscription = userLocationRequest.listen((req) {
      // TODO:

      switch (req.type) {
        case UserLocationRequestType.Add:
          {
            _userLocations.add(req.location);
            _updateMarkers();
            break;
          }
      }
    });
  }

  dispose() {
    _cameraZoomSubscription.cancel();

    _markerController.close();
    _cameraZoomController.close();
    _userLocationController.close();
  }

  _loadUserLocations() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> locationStrings = pref.getStringList('locations');

    if (locationStrings == null) {
      return;
    }

    locationStrings.forEach((loc) {
      _userLocations.add(UserLocation.fromJson(jsonDecode(loc)));
    });
  }

  _saveUserLocations() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> locationStrings = List<String>();
    pref.setStringList('locations',
        _userLocations.map((loc) => jsonEncode(loc.toJson())).toList());
  }

  _buildMediaPool() async {
    List<CaseLocation> locations = await api.getCaseLocations();
    locations.forEach((loc) {
      if (loc.latString != '' && loc.lngString != '') {
        MapMarker m = MapMarker(
          id: loc.id,
          position:
              LatLng(double.parse(loc.latString), double.parse(loc.lngString)),
          location: loc,
          isCluster: false,
        );

        _allCaseMarkers.add(m);
      }
    });

    _updateMarkers();
  }

  _updateMarkers() async {
    // filter the markers by user location
    Map<MarkerId, Marker> markers = Map();

    _allCaseMarkers.where((m) {
      if (_userLocations.length == 0) {
        return false;
      }
      return _userLocations
              ?.map((loc) =>
                  calculateDistance(loc.lat, loc.lng, m.position.latitude,
                      m.position.longitude) <
                  1)?.reduce((value, element) => value || element) ??
          false;
    }).forEach((m) {
      markers.putIfAbsent(
          MarkerId(m.id),
          () => Marker(
              markerId: MarkerId(m.id),
              position: m.position,
              // find a way to localize this
              infoWindow: InfoWindow(title: "test"),
              icon: _cachedIcon));
    });

    // Publish markers to subscribers.
    addMarkers(markers);
  }

  Future<images.Image> _createImage(
      String imageFile, int width, int height) async {
    ByteData imageData;
    try {
      imageData = await rootBundle.load('assets/$imageFile');
    } catch (e) {
      print('caught $e');
      return null;
    }

    if (imageData == null) {
      return null;
    }

    List<int> bytes = Uint8List.view(imageData.buffer);
    var image = images.decodeImage(bytes);

    return images.copyResize(image, width: width, height: height);
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
