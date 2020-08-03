import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:vote4hk_mobile/api/api.dart';
import 'package:fluster/fluster.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as images;
import 'package:vote4hk_mobile/models/case_location.dart';
import 'package:vote4hk_mobile/models/map_marker.dart';

// Reference: https://github.com/alfonsocejudo/fluster_demo/blob/master/lib/main_bloc.dart
class MapBloc {

  static const minZoom = 10;

  static const maxZoom = 21;

  BitmapDescriptor _cachedIcon;
  images.Image _cachedClusterBackground;

  // Current pool of available media that can be displayed on the map.
  final Map<String, MapMarker> _mediaPool;

  /// Markers currently displayed on the map.
  final _markerController = StreamController<Map<MarkerId, Marker>>.broadcast();

  /// Camera zoom level after end of user gestures / movement.
  final _cameraZoomController = StreamController<double>.broadcast();

  /// Outputs.
  Stream<Map<MarkerId, Marker>> get markers => _markerController.stream;
  Stream<double> get cameraZoom => _cameraZoomController.stream;

  /// Inputs.
  Function(Map<MarkerId, Marker>) get addMarkers => _markerController.sink.add;
  Function(double) get setCameraZoom => _cameraZoomController.sink.add;

  /// Internal listener.
  StreamSubscription _cameraZoomSubscription;

  /// Keep track of the current Google Maps zoom level.
  var _currentZoom = 12; // As per _initialCameraPosition in main.dart

  /// Fluster!
  Fluster<MapMarker> _fluster;

  MapBloc() : _mediaPool = LinkedHashMap<String, MapMarker>() {
    _buildMediaPool();

    _cameraZoomSubscription = cameraZoom.listen((zoom) {
      if (_currentZoom != zoom.toInt()) {
        _currentZoom = zoom.toInt();

        _displayMarkers(_mediaPool);
      }
    });
  }

  dispose() {
    _cameraZoomSubscription.cancel();

    _markerController.close();
    _cameraZoomController.close();
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

        _mediaPool[loc.id] = m;
      }
    });

    _fluster = Fluster<MapMarker>(
        minZoom: minZoom,
        maxZoom: maxZoom,
        radius: 100,
        extent: 1024,
        nodeSize: 32,
        points: _mediaPool.values.toList(),
        createCluster:
            (BaseCluster cluster, double longitude, double latitude) =>
                MapMarker(
                    id: cluster.id.toString(),
                    position: LatLng(latitude, longitude),
                    location: null,
                    isCluster: true,
                    clusterId: cluster.id,
                    pointsSize: cluster.pointsSize,
                    childMarkerId: cluster.childMarkerId));

    _displayMarkers(_mediaPool);
  }

  _displayMarkers(Map pool) async {
    if (_fluster == null) {
      return;
    }

    // Get the clusters at the current zoom level.
    List<MapMarker> clusters =
        _fluster.clusters([-180, -85, 180, 85], _currentZoom);

    // Finalize the markers to display on the map.
    Map<MarkerId, Marker> markers = Map();

    for (MapMarker feature in clusters) {
      BitmapDescriptor bitmapDescriptor;

      if (feature.isCluster) {
        // TODO: change to something else
        bitmapDescriptor = await _createClusterBitmapDescriptor(feature);
      } else {
        if (_cachedIcon == null){
          _cachedIcon = await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/pin.png');
        }
        bitmapDescriptor = _cachedIcon;
      }

      var marker = Marker(
          markerId: MarkerId(feature.markerId),
          position: LatLng(feature.latitude, feature.longitude),
          // find a way to localize this
          infoWindow: InfoWindow(title: "test"),
          icon: bitmapDescriptor);

      markers.putIfAbsent(MarkerId(feature.markerId), () => marker);
    }

    // Publish markers to subscribers.
    addMarkers(markers);
  }

  Future<BitmapDescriptor> _createClusterBitmapDescriptor(
      MapMarker feature) async {
    MapMarker childMarker = _mediaPool[feature.childMarkerId];

    var child = _cachedClusterBackground ?? await _createImage('cluster_bg.png', 100, 100);

    if (child == null) {
      return null;
    }

    images.brightness(child, -50);

    String text = '${feature.pointsSize}';
    images.drawString(child, images.arial_48, 50 - text.length * 15, 25, text);

    var resized =
        images.copyResize(child, width: 100, height: 100);

    var png = images.encodePng(resized);

    return BitmapDescriptor.fromBytes(png);
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
