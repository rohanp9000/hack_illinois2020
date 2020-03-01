import 'dart:async';

import 'package:fitness_app/navEngine.dart';
import 'package:fitness_app/pages/EmergencyContacts.dart';
import 'package:fitness_app/pages/PreferencesPage.dart';
import 'package:fitness_app/pages/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main.dart';
import 'map.dart';


class Welcome extends StatefulWidget {
    @override
    WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {

    @override
    initState() {
        super.initState();
        new Timer(const Duration(seconds: 2), onClose);
    }


    void onClose() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => navEngine()));
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            backgroundColor: Color.fromRGBO(37, 40, 95, 30) ,
            body: Stack(
                children: <Widget>[
                    Transform.translate(offset: const Offset(100, 300.0),
                        child: Container(
                            width: 200.0,
                            height: 200.0,
                            child: SpinKitWave(
                                itemBuilder: (_, int index) {
                                    return DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                        ),
                                    );
                                },
                                size: 50.0,
                            ),
                        ),),
                ],

            ),

        );
    }
}