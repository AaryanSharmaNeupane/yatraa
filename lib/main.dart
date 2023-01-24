import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yatraa/screens/login_screen.dart';
import 'package:yatraa/screens/sign_up_screen.dart';

import '../providers/bus_stop_location.dart';
import '../providers/driver_location.dart';
import '../screens/driver_form_screen.dart';
import '../screens/driver_screen.dart';

import '../screens/passenger_screen.dart';
import '../screens/rate_driver_screen.dart';
import '../screens/home.dart';
import '../screens/prepare_ride.dart';
import 'UI/splash.dart';

late SharedPreferences sharedPreferences;
// ignore: constant_identifier_names
const String MAPBOX_ACCESS_TOKEN =
    "pk.eyJ1IjoiYWFyeWFuLW5ldXBhbmUiLCJhIjoiY2xkYTV0N3U1MGZrMjN2bzJ4dDJnNmJkMiJ9._wIBq1H8aBpScg9jJk10ag";
const String serverUrl = "https://yatraa.up.railway.app";

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //for splash screen
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusStopLocation(),
      child: ChangeNotifierProvider(
        create: (context) => DriverLocation(),
        child: MaterialApp(
          title: 'Yatraa',
          theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: 'Quicksand',
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade600),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                enableFeedback: true,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) => const Splash(),
            Home.routeName: (context) => const Home(),
            PrepareRide.routeName: (context) => const PrepareRide(),
            DriverScreen.routeName: (context) => const DriverScreen(),
            PassengerScreen.routeName: (context) => const PassengerScreen(),
            RateDriverScreen.routeName: (context) => const RateDriverScreen(),
            DriverFormScreen.routeName: (context) => const DriverFormScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            SignupScreen.routeName: (context) => const SignupScreen(),
          },
        ),
      ),
    );
  }
}
