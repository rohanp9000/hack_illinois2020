import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/NavigationBar/AwesomeBottomNavigationBar.dart';

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

  Animation<Color> _colorAnimation;
  AnimationController _animationController;

  final List<Color> colors = [
    Color(0xFFEA0034),
    Colors.blue,
    Colors.amber,
    Colors.deepOrange,
    Colors.lightGreen
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _colorAnimation = ColorTween(
      begin: colors[_selectedIndex],
      end: colors[1],
    ).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
//        decoration: new BoxDecoration(
////            gradient: new LinearGradient(colors: [const Color(0xFFCA436B),const Color(0xFF915FB5)],
////                begin: FractionalOffset.topLeft,
////                end: FractionalOffset.bottomRight,
////                stops: [0.0,1.0],
////                tileMode: TileMode.clamp)
////        ),
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
                                color: Theme.of(context).accentColor,
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
      bottomNavigationBar: AwesomeBottomNavigationBar(
        bodyBackgroundColor: _colorAnimation.value,
        icons: [
          Icons.home,
          Icons.people,
          Icons.settings,
        ],
        tapCallback: (int index) {
          _animationController.reset();
          _colorAnimation = ColorTween(
            begin: colors[_selectedIndex],
            end: colors[index],
          ).animate(_animationController);
          _animationController.forward();
          _selectedIndex = index;
        },
      ),
    );
  }
}
