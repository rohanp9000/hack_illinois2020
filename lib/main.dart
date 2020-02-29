import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Position pos = null;
  void getLocation() async {
    pos = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  }

  List<Marker> allMarkers = [];

  @override
  void initState(){
    super.initState();
    allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      position:LatLng(40.102137, -88.236737),
      draggable:true,
      onDragEnd:((value){
        getLocation();
        print(pos.toString());
      }),
      onTap:(){
        getLocation();
        print(pos.toString());
      },

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