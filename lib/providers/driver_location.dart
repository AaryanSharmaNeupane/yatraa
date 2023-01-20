import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class DriverLocation with ChangeNotifier {
  final List<Map> _locations = [
    // {
    //   "id": "1",
    //   "latitude": 27.730531350484114,
    //   "longitude": 85.34509106747254,
    // },
    // {
    //   "id": "2",
    //   "latitude": 27.71722528698895,
    //   "longitude": 85.34675633721685,
    // },
    // {
    //   "id": "3",
    //   "latitude": 27.66664777342315,
    //   "longitude": 85.30824303859612,
    // },
    // {
    //   "id": "4",
    //   "latitude": 27.657974555388606,
    //   "longitude": 85.32252035198354,
    // },
  ];

  List get locations {
    return [..._locations];
  }

  void addLocation() async {
    var response = await Dio().get('$serverUrl/location/3/live/');

    var parsedResponse = {
      "latitude": response.data[0]['lat'],
      "longitude": response.data[0]['lon'],
    };
    // print(parsedResponse);
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
