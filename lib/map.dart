import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hackillinois/pages/EmergencyContacts.dart';


class Mapz extends StatefulWidget {
  @override
  MapzState createState() => MapzState();
}

class MapzState extends State<Mapz> {
  GoogleMapController mapController;
  static LatLng home = new LatLng(40.10298, -88.227419 );
  static const kGoogleApiKey = "AIzaSyAmiskK0obvHxJ4O8zBKtl7NRf_fsQ9i-g";
  static GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  static void setNewHome(double lat, double lon) {
    home = new LatLng(lat, lon);
    allMarkers.removeLast();
    allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      position: LatLng(lat, lon),
      draggable:true,
      onDragEnd:((value) {
        home = new LatLng(value.latitude, value.longitude);
      }),
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Position pos;
  void getLocation() async {
    pos = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  }

  static List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      position: LatLng(40.102137, -88.236737),
      draggable:true,
      onDragEnd:((value) {
        home = new LatLng(value.latitude, value.longitude);
      }),
    ));
    while (allMarkers.length > 1) {
      allMarkers.removeLast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Location'),
          backgroundColor: Colors.blue[700],
        ),

        body: Stack(
          children: <Widget>[
            _buildGoogleMap(context),
            _searchMap(context)
          ],
        )


      ),
    );
  }

  bool val = false;
  Widget _searchMap(BuildContext context) {
    return Container(
      child: Switch(
        value: val,
        onChanged: (bool new_value) {
          setState(() {
            val = new_value;
          });
          allMarkers.removeLast();
          allMarkers.add(Marker(
            markerId: MarkerId('myMarker'),
            position: home,
            draggable:val,
            onDragEnd:((value) {
              home = new LatLng(value.latitude, value.longitude);
              EmergencyContactsState.updateLatLon();
            }),
          ));
        },
      ),
    );
  }

  @override
  Widget _buildGoogleMap(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height*2/3,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(

        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(

          target: LatLng(40.102137, -88.236737),
          zoom: 11.0,
        ),
        markers: Set.from(allMarkers),
      ),
    );
  }

}