import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/NavigationBar/AwesomeBottomNavigationBar.dart';

class ContactsPage extends StatelessWidget {
  Animation<Color> _colorAnimation;
  AnimationController _animationController;

  final List<Color> colors = [
    Color(0xFFEA0034),
    Colors.blue,
    Colors.amber,
    Colors.deepOrange,
    Colors.lightGreen
  ];

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

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.black,
          title: Text("Contacts",
          style: TextStyle(
            fontSize: 45,
            fontFamily: 'Bebas',
            fontWeight: FontWeight.bold
          ),),

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
        body: new ContactList(kContacts));
  }
}

const kContacts = const <Contact>[
  const Contact(
      fullName: 'kunal', phoneNumber: 'kuntboy@example.com'),
  const Contact(
      fullName: 'cheese', phoneNumber: 'bruh@example.com')
];

class ContactList extends StatelessWidget {
  final List<Contact> _contacts;

  ContactList(this._contacts);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return new _ContactListItem(_contacts[index]);
      },
      itemCount: _contacts.length,
    );
  }
}

class _ContactListItem extends ListTile {
  _ContactListItem(Contact contact)
      : super(
      title: new Text(contact.fullName),
      subtitle: new Text(contact.phoneNumber),
      leading: new CircleAvatar(child: new Text(contact.fullName[0])));
}

class Contact {
  final String fullName;
  final String phoneNumber;

  const Contact({this.fullName, this.phoneNumber});
}