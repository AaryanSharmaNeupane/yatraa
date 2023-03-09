import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class BusStopLocation with ChangeNotifier {
  final List<Map> _locations = [];

  List get locations {
    return [..._locations];
  }

  Future<void> addLocation() async {
    var response = await Dio().get('$serverUrl/location/busroutes/');
    for (int i = 0; i < response.data.length; i++) {
      _locations.add(response.data[i]);
    }
    notifyListeners();
  }
}
