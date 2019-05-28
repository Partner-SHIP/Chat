import 'package:flutter/material.dart';
import 'package:flutter_app/add_contact.dart';
import 'contact_view.dart';
import 'home_page.dart';
import 'chat_screen.dart';
import 'contact_data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Chat App",
      home: new ContactsPage(),
      routes: {
        ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
        "/NewConv": (context) => new NewContactsPage(),
        "/ChatScreen": (context) => new Chat(),
      },

    );
  }
}