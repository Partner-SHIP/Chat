import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'contact_view.dart';

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/HomePage';
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(args.title),
          backgroundColor: Colors.green,
        ),
        body: new ChatScreen(args.title, args.conversation));
  }
}
