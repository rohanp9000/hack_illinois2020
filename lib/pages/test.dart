import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:fitness_app/NavigationBar/AwesomeBottomNavigationBar.dart';

class Test extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Test>
    with SingleTickerProviderStateMixin {
  bool cheese = false;
  String state = "disabled";
  bool thingy = true;
  int bruh = 0;
  TextStyle ye = new TextStyle(
    color: Colors.red,
    fontSize: 25,
    fontFamily: 'Bebas',
    fontWeight: FontWeight.normal,
  );

  int _selectedIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [const Color(0xABBA436B),const Color(0xAB235FB5)],
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
                              fontSize: 45,
                              fontFamily: 'Bebas',
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Padding(padding: EdgeInsets.fromLTRB(30,0,0, 0)),
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
                                          state = 'Enabled';
                                          ye = new TextStyle(
                                            color: Colors.green,
                                            fontSize: 25,
                                            fontFamily: 'Bebas',
                                            fontWeight: FontWeight.normal,
                                          );

                                        } else {
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 190, 0),
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


}