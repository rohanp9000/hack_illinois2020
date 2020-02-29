import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  GoogleMapController mapController;
  LatLng home = new LatLng(40.10298, -88.227419 );
  static const kGoogleApiKey = "AIzaSyAmiskK0obvHxJ4O8zBKtl7NRf_fsQ9i-g";
  static GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);


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
//            _buildGoogleMap(context),
            _searchMap(context)
          ],
        )


      ),
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }

  Widget _searchMap(BuildContext context) {
      return Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  // show input autocomplete with selected mode
                  // then get the Prediction selected
                  Prediction p = await PlacesAutocomplete.show(
                      context: context, apiKey: kGoogleApiKey);
                  displayPrediction(p);
                },
                child: Text('Find address'),

              )
          )
      );
  }

  @override
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