import 'package:flutter/material.dart';
import 'package:flutter_google_maps/components/google_maps_widget.dart';
import 'package:flutter_google_maps/models/user_location.dart';
import 'package:flutter_google_maps/provider/location_provider.dart';
import 'package:flutter_google_maps/services/location_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  void dispose() {
    LocationServices().closeLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locationProvider = Provider.of<LocationProvider>(context);
    print(locationProvider.userLocation);
    return Scaffold(
      appBar: AppBar(),
      body: StreamProvider<UserLocation>(
          initialData: locationProvider.userLocation,
          create: (context) => LocationServices().locationStream,
          child: MapsScreen()),
    );
  }
}

const double cameraZoom = 15;
const double cameraTilt = 50;
const double cameraBearing = 30;

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Position position;
  GoogleMapController mapControler;
  Completer<GoogleMapController> _controller = Completer();
  LatLng lastPosition;
  final Set<Marker> _markers = {};

  void dispose() {
    LocationServices().closeLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(builder: (context, LocationProvider provider, _) {
      if (provider.status == LocationProviderStatus.Loading ||
          provider.status == LocationProviderStatus.Initial) {
        return Center(child: CircularProgressIndicator());
      } else if (provider.status == LocationProviderStatus.Success) {
        var locationProvider = Provider.of<UserLocation>(context);

        CameraPosition initialCameraPosition = CameraPosition(
            zoom: cameraZoom,
            target:
                LatLng(locationProvider.latitude, locationProvider.longitude));
        // lastPosition = initialCameraPosition.target;

        animatedViewofMap(
            lat: locationProvider.latitude, lng: locationProvider.longitude);

        return Stack(children: [
          GoogleMapWidget(
              markers: _markers,
              initialCameraPosition: initialCameraPosition,
              controller: _controller,
              locationProvider: locationProvider),
        ]);
      } else {
        return Center(child: Text("We can't reach your location"));
      }
    }));
  }

  void animatedViewofMap({double lat, double lng}) async {
    CameraPosition cPosition = CameraPosition(
      zoom: cameraZoom,
      target: LatLng(lat, lng),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }
}
