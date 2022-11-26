import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:yatraa/widgets/app_drawer.dart';
import 'package:yatraa/widgets/hamburger_menu.dart';

import '../helpers/shared_prefs.dart';

class DriverScreen extends StatefulWidget {
  static const routeName = "/driver-screen";

  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  bool positive = getCurrentUserMode();
  // var scaffoldKey = GlobalKey<ScaffoldState>();

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

  _onStyleLoadedCallBack() async {
    await controller.addSymbol(
      SymbolOptions(
        geometry: currentLocation,
        iconSize: 1.5,
        iconImage: "assets/images/marker.png",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Stack(
        children: [
          MapboxMap(
            initialCameraPosition: _initialCameraPosition,
            accessToken:
                "pk.eyJ1IjoicnVzdHUtbmV1cGFuZSIsImEiOiJjbGFnN3N4emgxY2VzM29ydHlhc2ozbW41In0.HterCgrAMUExckM18JX8ig",
            compassEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoadedCallBack,
          ),

          // HamburgerMenu(scaffoldKey),

          // const AnimatedToggleButton(),
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