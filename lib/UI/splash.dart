import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../helpers/mapbox_handler.dart';
// import '../screens/home.dart';
import '../providers/bus_stop_location.dart';
import '../screens/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    initializeLocationAndSave();
  }

  void initializeLocationAndSave() async {
    bool firstRun = await IsFirstRun.isFirstRun();

    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    LocationData locationData = await location.getLocation();
    LatLng currentLocation =
        LatLng(locationData.latitude!, locationData.longitude!);

    String currentAddress =
        (await getParsedReverseGeocoding(currentLocation))['place'];

    // ignore: use_build_context_synchronously
    Provider.of<BusStopLocation>(context, listen: false).addLocation();

    sharedPreferences.setDouble('latitude', locationData.latitude!);
    sharedPreferences.setDouble('longitude', locationData.longitude!);
    sharedPreferences.setString('current-address', currentAddress);
    sharedPreferences.setBool("first-run", firstRun);

    // firstRun
    //     ?
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, (route) => false);
    // :
    // // ignore: use_build_context_synchronously
    // Navigator.pushNamedAndRemoveUntil(
    //     context, Home.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: const Color.fromARGB(255, 29, 141, 34),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_.png",
              fit: BoxFit.cover,
            ),
            Text(
              'Yatraa',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
