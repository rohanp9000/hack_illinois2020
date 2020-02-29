import "package:flutter/material.dart";
import 'map.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {

  @override
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hackillinois2020',
      theme: ThemeData(
        primaryColor: Color(0xff6200ee),
      ),
      home: Map(),


    );
  }
}