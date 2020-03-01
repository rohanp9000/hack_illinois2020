import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackillinois/map.dart';
import 'package:vibration/vibration.dart';
import 'package:sms/sms.dart';
import 'package:toast/toast.dart';

class Test extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Test>
    with SingleTickerProviderStateMixin {
  bool cheese = false;
  String state = "Disabled";
  bool thingy = true;
  int bruh = 0;
  TextStyle ye = new TextStyle(
    color: Colors.red,
    fontSize: 25,
    fontFamily: 'Bebas',
    fontWeight: FontWeight.normal,
  );

  int _selectedIndex = 0;
  LatLng home = MapzState.home;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int numIters = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [const Color(0xAB235FB5),const Color(0xABBA436B)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp)
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 30, 25, 25),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0,20,0, 0),
                  child: Align(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Party Mode ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Padding(padding: EdgeInsets.fromLTRB(0,0,30, 0)),
                          Column(
                            children: <Widget>[
                              Transform.scale(scale: 2.2,
                                  child:Switch(
                                    value: cheese,
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.red,
                                    inactiveTrackColor: Colors.redAccent,
                                    onChanged: (bool newVal) {
                                      setState(() {
                                        bruh++;
                                        if (bruh % 2 != 0) {
                                          locUpdater();
                                          numIters = 0;
                                          state = 'Enabled';
                                          ye = new TextStyle(
                                            color: Colors.green,
                                            fontSize: 25,
                                            fontFamily: 'Bebas',
                                            fontWeight: FontWeight.normal,
                                          );

                                        } else {
                                          numIters = 6;
                                          state = "Disabled";
                                          ye = new TextStyle(
                                            color: Colors.red,
                                            fontSize: 25,
                                            fontFamily: 'Bebas',
                                            fontWeight: FontWeight.normal,
                                          );
                                        }
                                        cheese = newVal;
                                      });
                                    },
                                  )
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(0,0,0,10)),
                            ],
                          )
                        ],
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 150, 0),
                  child: Text(
                    state,
                    style: ye,
                  ),
                ),
              ],
            ),

          ),
        ),
      ),

    );
  }

  void locUpdater() {
    print("Party starting");
    const oneSec = const Duration(seconds:3);
    new Timer.periodic(oneSec, timer_callback);
  }

  Position pos;
  void getLocation() async {
    pos = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  }

  double currDist = 0;
  LatLng curr_loc;
  void timer_callback(Timer t) {
    print("One timer cycle");
    this.getLocation();
    curr_loc = new LatLng(pos.latitude, pos.longitude);

    double dist = sqrt(pow(1852*(curr_loc.latitude - home.latitude), 2) + pow(1852*(curr_loc.longitude - home.longitude), 2));

    if (dist > 10 && currDist > 10) {
      numIters++;
      if (numIters == 5) {
        print("You're fucked");
        triggerAlert();
      }
    } else {
      numIters = 0;
    }
    currDist = dist;
  }

  static final int ALERT_TIME = 5000;
  void triggerAlert() {
    Vibration.vibrate(duration: ALERT_TIME, amplitude: 255);
    _showDialog();
  }

  void reset() {}

  static final String locUrl = "https://www.google.com/maps/search/?api=1&query=";
  void sendText() {
    print('send text');

    SmsSender sender = new SmsSender();

    SmsMessage message = new SmsMessage('0000000000', "Rohan Prasad is drunk again. Please pick him/her up from " +
                locUrl + curr_loc.latitude.toString() + "," + curr_loc.longitude.toString());
    sender.sendSms(message);

    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        Toast.show("Sent Text", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop();
          sendText();
        });
        return AlertDialog(
          title: new Text("Confirmation"),
          content: new Text("Sending text in 5..."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
                reset();
              },
            ),
          ],
        );
      },
    );
  }

}