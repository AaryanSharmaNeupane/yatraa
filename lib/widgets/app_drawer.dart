import 'dart:async';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:provider/provider.dart';
// import 'package:yatraa/providers/bus_stop_location.dart';

import '../screens/driver_form_screen.dart';
import '../helpers/shared_prefs.dart';
import '../main.dart';
import '../screens/driver_screen.dart';
import '../screens/passenger_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isDriverMode = getCurrentUserMode();
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  final Dio _dio = Dio();
  // ignore: prefer_typing_uninitialized_variables
  Timer? timer;
  String url = "$serverUrl/location/create/1/";

  Widget buildDrawerHeader() {
    return DrawerHeader(
      child: Row(
        children: [
          CircleAvatar(
              backgroundImage: isDriverMode == true
                  ? const AssetImage("assets/images/driver.jpg")
                  : const AssetImage("assets/images/passenger.jpg"),
              radius: 44),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Hello there fellow",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  isDriverMode == true ? "driver" : "passenger",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade300,
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: buildDrawerHeader(),
          ),
          AnimatedToggleSwitch<bool>.dual(
            current: isDriverMode,
            first: false,
            second: true,
            dif: 121.0,
            borderColor: Colors.transparent,
            borderWidth: 5.0,
            height: 55,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ],
            onChanged: (b) {
              setState(() {
                isDriverMode = b;
                sharedPreferences.setBool('user-mode', isDriverMode);
                if (isDriverMode == true) {
                  double lat = currentLocation.latitude;
                  double lon = currentLocation.longitude;
                  String data = "{\"lon\":\"$lon\",\"lat\":\"$lat\"}";
                  // timer = Timer.periodic(
                  //     const Duration(seconds: 5),
                  //     (Timer t) =>
                  _dio.post(
                    Uri.parse(url).toString(),
                    data: data,
                    options: Options(
                      headers: {'Cookie': 'jwt=${getToken()}'},
                    ),
                  );

                  // );
                  sharedPreferences.getStringList("driver-information") == null
                      ? Navigator.of(context)
                          .pushNamed(DriverFormScreen.routeName)
                      : Navigator.of(context).pushNamed(DriverScreen.routeName);
                } else {
                  Navigator.of(context).pushNamed(PassengerScreen.routeName);
                }
              });
            },
            iconBuilder: (value) => value
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      "assets/images/driver.jpg",
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset("assets/images/passenger.jpg")),
            textBuilder: (value) => value
                ? const Center(
                    child: Text(
                      "Driver's Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      "Passenger's Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          const Divider(),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(DriverFormScreen.routeName);
            },
            child: const Text("Edit Form"),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
