import 'package:flutter/material.dart';
import 'package:flutter_app/contact_view.dart';
import 'package:flutter_app/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Chat App",
        home: new ContactsPage(),
      routes: {
        ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
      },

        )
    ;
  }
}