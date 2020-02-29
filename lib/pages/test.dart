import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Test extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Test> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final double total;
  final double achieved;
  final Image image;
  final Color color;

  const StatCard({
    Key key,
    @required this.title,
    @required this.total,
    @required this.achieved,
    @required this.image,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).accentColor.withAlpha(100),
                  fontSize: 14,
                ),
              ),
              achieved < total
                  ? Image.asset(
                'assets/img/down_orange.png',
                width: 20,
              )
                  : Image.asset(
                'assets/img/up_red.png',
                width: 20,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: achieved / (total < achieved ? achieved : total),
            circularStrokeCap: CircularStrokeCap.round,
            center: image,
            progressColor: color,
            backgroundColor: Theme.of(context).accentColor.withAlpha(30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: achieved.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
              TextSpan(
                text: ' / $total',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
