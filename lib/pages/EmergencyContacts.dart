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
              minHeight: 65,
              maxHeight: 260,
              panel: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //<-- move text top
                children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),),
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
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),),
                      Column(
                          children: <Widget>[
                              Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0),),

                              Text("NAME: ", style: TextStyle(fontSize: 20),),
                          ],
                      ),
                      Container(
                        width: 120.0,
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
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),),
                        Column(
                            children: <Widget>[
                                Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0),),

                                Text("NUMBER: ", style: TextStyle(fontSize: 20),),
                            ],
                        ),
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
                  Row(
                      children: <Widget>[
                          Padding(padding: EdgeInsets.fromLTRB(130, 100, 0, 0),),
                          RaisedButton(
                              child: Text("Add contact"),
                              onPressed: () {
                                  addContact(tempName, tempNum);
                                  (context as Element).markNeedsBuild();
                              }
                              //onPressed: addContact(tempName, tempNum),
                          ),
                      ],
                  ),
                ],
              ),
            )
          ],
        ));
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
  List<Contact> _contacts;

  EmergencyContactsList(this._contacts);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
          try {
              return new _ContactListItem(_contacts[index], context);
          } catch(e){}
      },
      itemCount: _contacts.length,
    );
  }
}

class _ContactListItem extends ListTile {
  _ContactListItem(Contact contact, BuildContext context)
      : super(
          title: new Text(contact.fullName),
          subtitle: new Text(contact.phoneNumber),
          leading: new CircleAvatar(child: new Text(contact.fullName[0])),
            trailing: new IconButton(icon: Icon(Icons.delete), onPressed: () {

                kContacts.remove(contact);
                (context as Element).markNeedsBuild();
            })

        );
}

class Contact {
  final String fullName;
  final String phoneNumber;

  const Contact({this.fullName, this.phoneNumber, });
}
