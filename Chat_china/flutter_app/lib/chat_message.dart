import 'package:flutter/material.dart';
import 'home_page.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String name;
  final String date;

  ChatMessage({this.name, this.text, this.date});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              child: new Text(name),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(date),
              )
            ],
          )
        ],
      ),
    );
  }
}
