//access token is required

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:yatraa/screens/passenger_screen.dart';

// import '../providers/driver_location.dart';
import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';
import '../helpers/commons.dart';
import '../main.dart';
import '../providers/bus_stop_location.dart';
import '../widgets/review_ride_bottom_sheet.dart';

class ReviewRide extends StatefulWidget {
  final Map modifiedResponse;
  final LatLng driverLatlng;
  const ReviewRide(
      {Key? key, required this.modifiedResponse, required this.driverLatlng})
      : super(key: key);

  @override
  State<ReviewRide> createState() => _ReviewRideState();
}

class _ReviewRideState extends State<ReviewRide> {
  final List<CameraPosition> _kTripEndPoints = [];
  late MapboxMapController controller;
  late CameraPosition _initialCameraPosition;
  late LatLng initialLatlng;

  late List<CameraPosition> busStopLocationCoordinates;
  // late List<CameraPosition> driverLocationCoordinates;

  late String distance;
  late String dropOffTime;
  late Map geometry;

  // String url = "$serverUrl/location/create/2/";

  StreamController latlngController = StreamController();
  // ignore: prefer_typing_uninitialized_variables
  var driverSymbol;

  @override
  void initState() {
    _initialiseDirectionsResponse();
    _initialCameraPosition = CameraPosition(
      target: getCenterCoordinatesForPolyline(geometry),
      zoom: 14,
    );

    for (String type in ['source', 'destination']) {
      _kTripEndPoints
          .add(CameraPosition(target: getTripLatLngFromSharedPrefs(type)));
    }
    super.initState();
  }

  _initialiseDirectionsResponse() {
    distance = (widget.modifiedResponse['distance'] / 1000).toStringAsFixed(1);
    dropOffTime = getDropOffTime(widget.modifiedResponse['duration']);
    geometry = widget.modifiedResponse['geometry'];
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _updateMarker() async {
    var response = await Dio().get('$serverUrl/location/1/live/');
    initialLatlng = LatLng(response.data[0]['lat'], response.data[0]['lon']);
    latlngController.sink.add(initialLatlng);
  }

  _onStyleLoadedCallback(val) async {
    // ignore: prefer_typing_uninitialized_variables

    for (CameraPosition coordinates in busStopLocationCoordinates) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: coordinates.target,
          iconSize: 1.5,
          iconImage: "assets/images/bus-stop.png",
        ),
      );
    }
    if (driverSymbol != null) {
      await controller.removeSymbol(driverSymbol);
    }

    driverSymbol = await controller.addSymbol(
      SymbolOptions(
        geometry: val,
        iconSize: 1.5,
        iconImage: "assets/images/marker.png",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initialLatlng = widget.driverLatlng;
    final busStopLocationData = Provider.of<BusStopLocation>(context);
    final busStopLocation = busStopLocationData.locations;
    busStopLocationCoordinates = List<CameraPosition>.generate(
      busStopLocation.length,
      (index) => CameraPosition(
        target: LatLng(busStopLocation[index]['latitude'],
            busStopLocation[index]['longitude']),
        zoom: 15,
      ),
    );
    Timer.periodic(const Duration(seconds: 5), (Timer t) => _updateMarker());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Review Ride'),
        actions: [
          IconButton(
              onPressed: () async {
                var response = await Dio().get('$serverUrl/location/1/live/');
                initialLatlng =
                    LatLng(response.data[0]['lat'], response.data[0]['lon']);
                latlngController.sink.add(initialLatlng);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder(
                  stream: latlngController.stream,
                  builder: (context, snapshot) {
                    _onStyleLoadedCallback(initialLatlng);
                    return MapboxMap(
                      accessToken: MAPBOX_ACCESS_TOKEN,
                      initialCameraPosition: _initialCameraPosition,
                      myLocationEnabled: true,
                      onMapCreated: _onMapCreated,
                      onStyleLoadedCallback: () =>
                          _onStyleLoadedCallback(initialLatlng),
                      myLocationTrackingMode:
                          MyLocationTrackingMode.TrackingGPS,
                    );
                  }),
            ),
            reviewRideBottomSheet(context, distance, dropOffTime),
            Positioned(
              right: 5,
              bottom: 230,
              child: SizedBox(
                height: 35,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    controller.animateCamera(
                        CameraUpdate.newCameraPosition(_initialCameraPosition));
                  },
                  child: const Icon(Icons.my_location),
                ),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 275,
              child: SizedBox(
                height: 35,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    Navigator.of(context).pushNamed(PassengerScreen.routeName);
                  },
                  child: const Icon(Icons.home_filled),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
