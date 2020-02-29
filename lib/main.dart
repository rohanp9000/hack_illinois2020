import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;
  LatLng home = new LatLng(37.4219983, -122.084 );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Position pos;
  void getLocation() async {
    pos = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void main() {
    const oneSec = const Duration(seconds:1);
    new Timer.periodic(oneSec, timer_callback);
  }

  void timer_callback(Timer t) {
    this.getLocation();
    LatLng curr_loc = new LatLng(pos.latitude, pos.longitude);

    double dist = sqrt(pow(1852*(curr_loc.latitude - home.latitude), 2) + pow(1852*(curr_loc.longitude - home.longitude), 2));
    print(dist);
  }

  List<Marker> allMarkers = [];

  @override
  void initState(){
    super.initState();
    main();
    allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      position: LatLng(40.102137, -88.236737),
      draggable:true,
      onDragEnd:((value) {
        home = new LatLng(value.latitude, value.longitude);
      }),
    ));

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Location'),
          backgroundColor: Colors.blue[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(

            target: LatLng(40.102137, -88.236737),
            zoom: 11.0,
          ),
          markers: Set.from(allMarkers),
        ),

      ),
    );
  }
}