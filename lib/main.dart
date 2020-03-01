import 'package:fitness_app/pages/EmergencyContacts.dart';
import 'package:fitness_app/pages/test.dart';
import 'package:fitness_app/pages/PreferencesPage.dart';
import 'package:fitness_app/welcome.dart';
import 'package:flutter/material.dart';
import 'map.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}
class MyAppState extends State<MyApp> {

  var _pageOptions = [
    Welcome(),
    Test(),
    EmergencyContacts(),
    Mapz(),
    PreferencesPage(),
  ];

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: _selectedTab == 0? null: BottomNavigationBar(
          unselectedItemColor: Colors.black54,
          selectedItemColor: Color.fromRGBO(37, 40, 105, 30),
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() {
                _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              title: Text('Contacts'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Map'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Preferences'),
            ),
          ],
        ),
      ),
    );
  }}