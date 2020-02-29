import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    body: Center (
      child: Text('Party Mode is Currently '),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: Text('off'),
      backgroundColor: Colors.black,
    ),
  ),
));

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


