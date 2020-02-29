import 'package:fitness_app/pages/ContactsPage.dart';
import 'package:fitness_app/pages/EmergencyContacts.dart';
import 'package:fitness_app/pages/test.dart';
import 'package:fitness_app/pages/PreferencesPage.dart';
import 'package:fitness_app/pages/welcome.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}
class MyAppState extends State<MyApp> {
  int _selectedTab = 0;
  final _pageOptions = [
    Test(),
    EmergencyContacts(),
    //ContactsPage(),
    PreferencesPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.white60,
          primarySwatch: Colors.blue,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          )),
      home: Scaffold(
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(Icons.settings),
              title: Text('Preferences'),
            ),
          ],
        ),
      ),
    );
  }}