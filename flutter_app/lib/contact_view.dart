import 'package:flutter/material.dart';
import 'contact_data.dart';
import 'package:flutter_app/home_page.dart';

class ScreenArguments {
  String title;
  String message;

  ScreenArguments(this.title, this.message);
}

class _ContactListItem extends StatefulWidget {
  final _ContactState _state = _ContactState();

  @override
  State<_ContactListItem> createState() {
    // TODO: implement createState
    return _state;
  }

}

class _ContactState extends State<_ContactListItem> {
   Contact _contact;

  @override
  void initState() {
    // TODO: implement deactivate
    super.initState();
    _contact = Contact(fullName: 'Contact Name', email: 'Message');

  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
            child: Text(_contact.fullName[0])
        ),
        title: Text(_contact.fullName),
        subtitle: Text(_contact.email),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => ExtractArgumentsScreen()),
          );
          Navigator.pushNamed(
            context,
            ExtractArgumentsScreen.routeName,
            arguments: ScreenArguments(
              _contact.fullName,
              'This message is extracted in the build method.',
            ),
          );
        }
    );
  }
}



class ContactList extends StatelessWidget {

  final List<Contact> _contacts;

  ContactList(this._contacts);

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList()
    );
  }

  List<_ContactListItem> _buildContactList() {
    return _contacts.map((contact) => _ContactListItem())
        .toList();
  }

}

class ContactsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("Conversations"),
        ),
        body: ContactList(kContacts),
      floatingActionButton: FloatingActionButton(
          child: Text('New'),
          onPressed: () { print("Button Pressed"); }),
    );
  }
}
