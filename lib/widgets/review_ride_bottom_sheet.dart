import 'package:flutter/material.dart';
import 'package:yatraa/screens/passenger_screen.dart';
// import 'package:yatraa/screens/rate_driver_screen.dart';
import '../helpers/commons.dart';
import '../helpers/shared_prefs.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

Widget reviewRideBottomSheet(
    BuildContext context, String distance, String dropOffTime) {
  // Get source and destination addresses from sharedPreferences
  String sourceAddress = getSourceAndDestinationPlaceText('source');
  String destAddress = getSourceAndDestinationPlaceText('destination');

  double money = getMoney(double.parse(distance));

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
                Text('$sourceAddress ➡ $destAddress',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.indigo)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    leading: CircleAvatar(
                      radius: 19,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: Image.asset(
                          'assets/images/bus.png',
                        ),
                      ),
                    ),
                    title: const Text('Ride Review',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('$distance km, $dropOffTime drop off'),
                    trailing: Text('Rs.${money.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                ),
                KhaltiScope(
                publicKey: "test_public_key_17fdd385389b41a4b20af551b9da1766",
                enabledDebugging: true,
                builder: (context, navKey) {
                  return MaterialApp(
                    title: 'Khalti Demo',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                    ),
                    home: const KhatiScreen(),
                    navigatorKey: navKey,
                    localizationsDelegates: const [
                      KhaltiLocalizations.delegate,
                    ],
                  );
                })
                // ElevatedButton(
                //   onPressed: () {
                //     //payment
                //   },
                //   style: ElevatedButton.styleFrom(
                //       padding: const EdgeInsets.all(20)),
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         // Text('Rate Your Driver'),
                //         Text("Pay with Khalti"),
                //       ]),
                // ),
              ]),
              
        ),
      ),
    ),
  );
}
