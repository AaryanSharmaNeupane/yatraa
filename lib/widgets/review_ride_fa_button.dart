import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:provider/provider.dart';

import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';
import '../main.dart';
// import '../providers/driver_location.dart';
import '../screens/review_ride.dart';

Widget reviewRideFaButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.airline_seat_recline_extra_sharp),
      onPressed: () async {
        // Get directions API response and pass to modified response

        LatLng sourceLatLng = getTripLatLngFromSharedPrefs('source');
        LatLng destinationLatLng = getTripLatLngFromSharedPrefs('destination');

        Map modifiedResponse =
            await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        // ignore: use_build_context_synchronously
        // Provider.of<DriverLocation>(context, listen: false).addLocation();

        var response = await Dio().get('$serverUrl/location/1/live/');
        // var parsedResponse = {
        //   "latitude": response.data[0]['lat'],
        //   "longitude": response.data[0]['lon'],
        // };

        // print(parsedResponse);
        Future.delayed(
          const Duration(seconds: 2),
        ).then((value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReviewRide(
                modifiedResponse: modifiedResponse,
                driverLatlng:
                    LatLng(response.data[0]['lat'], response.data[0]['lon']),
              ),
            )));
      },
      label: const Text('Review Ride'));
}
