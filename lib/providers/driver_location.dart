import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class DriverLocation with ChangeNotifier {
  final List<Map> _locations = [];

  List get locations {
    return [..._locations];
  }

  void addLocation() async {
    var response = await Dio().get('$serverUrl/location/3/live/');

    var parsedResponse = {
      "latitude": response.data[0]['lat'],
      "longitude": response.data[0]['lon'],
    };

    _locations.add(parsedResponse);
    Timer.periodic(
      const Duration(seconds: 5),
      (Timer t) async {
        var response = await Dio().get('$serverUrl/location/3/live/');
        updateLocation(response.data[0]['lat'], response.data[0]['lon']);
      },
    );
    notifyListeners();
  }

  void updateLocation(double lon, double lat) {
    _locations[0]['latitude'] = lat;
    _locations[0]['longitude'] = lat;
    notifyListeners();
  }
}
