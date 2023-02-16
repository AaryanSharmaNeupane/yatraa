import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class DriverLocation with ChangeNotifier {
  final List<Map> _locations = [];

  List get locations {
    return [..._locations];
  }

  void addLocation() async {
    var response = await Dio().get('$serverUrl/location/1/live/');

    var parsedResponse = {
      "latitude": response.data[0]['lat'],
      "longitude": response.data[0]['lon'],
    };
    // print(parsedResponse);
    _locations.add(parsedResponse);

    notifyListeners();
  }
}
