import 'package:flutter/material.dart';
import 'package:flutter_app/chat_screen.dart';
import 'contact_view.dart';

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/HomePage';
  static String contact;
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    contact = args.title;
    print('args.title =  $args.title');
    print('contact = $contact');
    return new Scaffold(
        appBar: new AppBar(
          //title: new Text(args.title),
          backgroundColor: Colors.green,
        ),
        body: new ChatScreen());
  }
}


