import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
//    mapController = controller;
  }

  void _getCurrentLocation() async {
    final position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps App'),
          backgroundColor: Colors.green[700],
        ),
        body: Align (
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  _getCurrentLocation();
                }, child: Text("Find Loc"),
              )
            ],
          ),
        ),
      ),
    );
  }
}