import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
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