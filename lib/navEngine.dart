import 'package:fitness_app/pages/EmergencyContacts.dart';
import 'package:fitness_app/pages/test.dart';
import 'package:fitness_app/pages/PreferencesPage.dart';
import 'package:flutter/material.dart';
import 'map.dart';


class navEngine extends StatefulWidget {

    @override
    State<StatefulWidget> createState() {
        return navEngineState();
    }
}
class navEngineState extends State<navEngine> {

    var _pageOptions = [
        Test(),
        EmergencyContacts(),
        Mapz(),
        PreferencesPage(),
    ];

    int _selectedTab = 0;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
                body: _pageOptions[_selectedTab],
                bottomNavigationBar: BottomNavigationBar(
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
            );
    }}