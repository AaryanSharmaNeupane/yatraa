import 'package:flutter/material.dart';

class BusStopLocation with ChangeNotifier {
  final List<Map> _locations = [
    {
      'id': 1,
      'address': 'R',
      'latitude': 27.73066283502807,
      'longitude': 85.34758484239046,
    },
    {
      'id': 2,
      'address': 'u',
      'latitude': 27.730195645064825,
      'longitude': 85.35621853819345,
    },
    {
      'id': 3,
      'address': 's',
      'latitude': 27.67920472602175,
      'longitude': 85.32652301220861,
    },
    {
      'id': 4,
      'address': 't',
      'latitude': 27.680974791341768,
      'longitude': 85.3234030602186,
    },
  ];

  List get locations {
    return [..._locations];
  }

  void addLocation() {
    //_locations.add(value);
    notifyListeners();
  }
}