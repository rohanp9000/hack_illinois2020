import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class PreferencesPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.black,
          title: Text("Preferences",
            style: TextStyle(
                fontSize: 45,
                fontFamily: 'Bebas',
                fontWeight: FontWeight.bold
            ),),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextField(
                controller: controller,
                decoration: InputDecoration.collapsed(hintText: "Enter Message Here"),
              ),
              OutlineButton(
                child: Text("Save Message"),
                onPressed: () {
                },
              ),
            ],
          )
        ),
    );
  }
}