import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_google_maps/models/user_location.dart';
import 'package:flutter_google_maps/services/location_services.dart';

enum LocationProviderStatus {
  Initial,
  Loading,
  Success,
  Error,
}

class LocationProvider with ChangeNotifier {
  UserLocation _userLocation;
  LocationServices _locationServices = LocationServices();

  LocationProviderStatus _status = LocationProviderStatus.Initial;

  UserLocation get userLocation => _userLocation;

  LocationProviderStatus get status => _status;

  Future<void> getLocation() async {
    try {
      _updateStatus(LocationProviderStatus.Loading);

      _userLocation = await _locationServices.getCurrentLocation();
      print(_userLocation);

      _updateStatus(LocationProviderStatus.Success);
    } catch (e) {
      _updateStatus(LocationProviderStatus.Error);
    }
  }

  void _updateStatus(LocationProviderStatus status) {
    if (_status != status) {
      developer
          .log('LocationProvider: Status updated from: $_status to: $status');
      _status = status;
      notifyListeners();
    }
  }
}
