//access token is required

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

import '../screens/prepare_ride.dart';
import '../providers/bus_stop_location.dart';
import 'navigation.dart';
import '../helpers/mapbox_handler.dart';
import '../helpers/commons.dart';
import '../main.dart';

class BusStopPath extends StatefulWidget {
  final Map modifiedResponse;
  final LatLng sourceLatLng;
  final LatLng destLatLng;
  final String sourceAddress;
  final String destAddress;
  const BusStopPath({
    Key? key,
    required this.modifiedResponse,
    required this.sourceLatLng,
    required this.destLatLng,
    required this.sourceAddress,
    required this.destAddress,
  }) : super(key: key);

  @override
  State<BusStopPath> createState() => _ReviewRideState();
}

class _ReviewRideState extends State<BusStopPath> {
  final List<CameraPosition> _kTripEndPoints = [];
  late MapboxMapController controller;
  late CameraPosition _initialCameraPosition;

  late String distance;
  late String dropOffTime;
  late Map geometry;

  late List<CameraPosition> busStopLocationCoordinates;
  @override
  void initState() {
    _initialiseDirectionsResponse();
    _initialCameraPosition = CameraPosition(
      target: getCenterCoordinatesForPolyline(geometry),
      zoom: 14,
    );
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
    for (int i = 0; i < _kTripEndPoints.length; i++) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kTripEndPoints[i].target,
        ),
      );
    }
    _addSourceAndLineLayer();
  }

  _addSourceAndLineLayer() async {
    final fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    await controller.addSource("fills", GeojsonSourceProperties(data: fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.green.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final busStopLocation = Provider.of<BusStopLocation>(context).locations;

    busStopLocationCoordinates = List<CameraPosition>.generate(
      busStopLocation.length,
      (index) => CameraPosition(
        target: LatLng(busStopLocation[index]['latitude'],
            busStopLocation[index]['longitude']),
        zoom: 15,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Path for bus stop'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MapboxMap(
                accessToken: MAPBOX_ACCESS_TOKEN,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
              ),
            ),
            Positioned(
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
                          Text(
                            '${widget.sourceAddress.substring(0, widget.sourceAddress.indexOf(","))} ➡ ${widget.destAddress}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.indigo),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              tileColor: Colors.grey[200],
                              leading: const CircleAvatar(
                                  radius: 25,
                                  child: Icon(Icons.directions_walk_outlined)),
                              title: const Text('Details',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                children: [
                                  Text(
                                      '$distance km,Can reach there by $dropOffTime'),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(PrepareRide.routeName);
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Search your destination'),
                                ]),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 230,
              child: SizedBox(
                height: 44,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Navigation(
                              sourceLatLng: widget.sourceLatLng,
                              destLatLng: widget.destLatLng),
                        ));
                  },
                  child: const Icon(Icons.directions),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
