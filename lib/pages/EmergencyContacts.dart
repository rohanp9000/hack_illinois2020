import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EmergencyContacts extends StatelessWidget {
  final myController = TextEditingController();
  final myController2 = TextEditingController();

  String tempName;
  String tempNum;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Contacts",
            style: TextStyle(
                fontSize: 45, fontFamily: 'Bebas', fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Center(child: new EmergencyContactsList(kContacts)),
            SlidingUpPanel(
              minHeight: 100,
              panel: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //<-- move text top
                children: <Widget>[
                  Center(
                    child: Text(
                      "New Contact",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'Bebas',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text("NAME: "),
                      Container(
                        width: 100.0,
                        child: TextField(
                            onChanged: (text) {
                                tempName = text;
                            },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("NUMBER: "),
                      Container(
                        width: 100.0,
                        child: TextField(
                            onChanged: (text) {
                                tempNum = text;
                            },
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                      child: Text("Add contact"),
                      onPressed: () {
                        addContact(tempName, tempNum);

                      }
                      //onPressed: addContact(tempName, tempNum),
                      ),
                ],
              ),
            )
          ],
        ));
  }

  printNames() {
    for (int i = 0; i < kContacts.length; i++) {
      print("$i " + kContacts.elementAt(i).fullName);
    }
  }

  initializeName(String name) {
    tempName = name;
  }

  initializeNum(String num) {
    tempNum = num;
  }

  addContact(String name, String number) {
    kContacts.add(Contact(fullName: name, phoneNumber: number));
  }
}

List<Contact> kContacts = <Contact>[
  Contact(fullName: 'kunal', phoneNumber: 'kuntboy@example.com'),
  Contact(fullName: 'cheese', phoneNumber: 'bruh@example.com')
];

class EmergencyContactsList extends StatelessWidget {
  final List<Contact> _contacts;

  EmergencyContactsList(this._contacts);

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
          //leading: new CircleAvatar(child: new Text(contact.fullName[0]))
        );
}

class Contact {
  final String fullName;
  final String phoneNumber;

  const Contact({this.fullName, this.phoneNumber});
}
