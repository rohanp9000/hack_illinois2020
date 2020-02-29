import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:search_map_place/search_map_place.dart';


class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  GoogleMapController mapController;
  LatLng home = new LatLng(40.10298, -88.227419 );

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
          title: Text('Home Location'),
          backgroundColor: Colors.blue[700],
        ),

        body: Stack(
          children: <Widget>[
            _buildGoogleMap(context),
          ],
        )


      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height/2,
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