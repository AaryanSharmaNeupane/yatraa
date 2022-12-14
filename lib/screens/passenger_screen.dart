import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

import '../widgets/journey_review_bottom_sheet.dart';
import '../helpers/commons.dart';
import '../providers/bus_stop_location.dart';
import '../main.dart';
import '../widgets/app_drawer.dart';
import '../widgets/hamburger_menu.dart';
import '../helpers/mapbox_handler.dart';
import '../screens/prepare_ride.dart';
import '../helpers/shared_prefs.dart';

class PassengerScreen extends StatefulWidget {
  static const routeName = '/passenger-screen';
  const PassengerScreen({super.key});
  @override
  State<PassengerScreen> createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  late List<CameraPosition> busStopLocationCoordinates;

  late String distance;
  late String dropOffTime;
  late Map geometry;

  @override
  void initState() {
    //Set initial camera position and current address
    _initialCameraPosition = CameraPosition(target: currentLocation, zoom: 14);
    currentAddress = getCurrentAddressFromSharedPrefs();
    super.initState();
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    for (CameraPosition coordinates in busStopLocationCoordinates) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: coordinates.target,
          iconSize: 1.5,
          iconImage: "assets/images/bus-stop.png",
        ),
      );
    }
    controller.onSymbolTapped.add(_onSymbolTapped);
  }

//   Future<LatLng> getSymbolLatLng(Symbol symbol) async {
//   return symbol.options.geometry!;
// }

  void _onSymbolTapped(Symbol symbol) async {
    LatLng sourceLatLng = currentLocation;
    LatLng destinationLatLng = symbol.options.geometry!;
    final destAddress =
        await getReverseGeocodingforDestination(destinationLatLng);

    Map modifiedResponse =
        await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);
    distance = (modifiedResponse['distance'] / 1000).toStringAsFixed(1);
    dropOffTime = getDropOffTime(modifiedResponse['duration']);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return JourneyReviewBottomSheet(
            context,
            sourceLatLng,
            destinationLatLng,
            modifiedResponse,
            distance,
            dropOffTime,
            destAddress,
          );
        });
  }

  Widget buildPassengerScreenBottom() {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Hi there!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text('You are currently here:'),
                Text(currentAddress,
                    style: const TextStyle(color: Colors.indigo)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(PrepareRide.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Where do you wanna go today?'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          MapboxMap(
            initialCameraPosition: _initialCameraPosition,
            accessToken: MAPBOX_ACCESS_TOKEN,
            compassEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoadedCallback,
          ),
          hamburgerMenu(scaffoldKey),
          buildPassengerScreenBottom(),
          Positioned(
            right: 5,
            bottom: 200,
            child: SizedBox(
              height: 35,
              child: FloatingActionButton(
                onPressed: () {
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(_initialCameraPosition));
                },
                child: const Icon(Icons.my_location),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
