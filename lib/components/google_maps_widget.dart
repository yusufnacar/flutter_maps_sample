import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps/models/user_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    Key key,
    @required Set<Marker> markers,
    @required this.initialCameraPosition,
    @required Completer<GoogleMapController> controller,
    @required this.locationProvider,
  })  : _markers = markers,
        _controller = controller,
        super(key: key);

  final Set<Marker> _markers;
  final CameraPosition initialCameraPosition;
  final Completer<GoogleMapController> _controller;
  final UserLocation locationProvider;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: _markers,
      initialCameraPosition: initialCameraPosition,
      myLocationEnabled: true,
      mapToolbarEnabled: true,
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);

        _markers.add(buildMarker());
      },
    );
  }

  Marker buildMarker() {
    return Marker(
      markerId: MarkerId('<MARKER_ID>'),
      position: LatLng(locationProvider.latitude, locationProvider.longitude),
      infoWindow: InfoWindow(
        title: "Any place on the Earth is that so special for you",
      ),
      draggable: false,
    );
  }
}
