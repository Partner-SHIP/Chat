import 'package:flutter/material.dart';
import 'contact_data.dart';
import 'home_page.dart';

class ScreenArguments {
  String title;
  String message;
  ScreenArguments(this.title, this.message);
}

class _ContactListItem extends StatelessWidget {
  String title, subtitle;
  _ContactListItem(this.title, this.subtitle);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.title),
      subtitle: Text(subtitle),
      leading: CircleAvatar(
          child: Text(this.title)
      ),
      onTap: () => Navigator.pushNamed(context, ExtractArgumentsScreen.routeName, arguments: ScreenArguments(this.title, this.subtitle)),
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
    return _contacts.map((contact) => _ContactListItem(contact.fullName, contact.email))
        .toList();
  }

}

class ContactsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ContactsPageState();
  }
}

class ContactsPageState extends State<ContactsPage> {

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