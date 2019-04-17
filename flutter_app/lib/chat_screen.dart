import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  int i = 0;
  int i2 = 0;

/*  @override
  void initState() {
    StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("chat").snapshots(),
      builder: (context, snapshot) {
        i = 10;
      },
    );
    super.initState();
  }*/

  int _handleSubmitted(String text, bool b) {
    if (text.length > 0) {
      _textController.clear();
      ChatMessage message = new ChatMessage(
        text: text,
      );

      //    /*if (b == false) {
      setState(() {
        _messages.insert(0, message);
        i++;
      });
      //  } else*/
      //  i2++;
    }
  }

  Widget _textComposerWidget() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.green),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
                controller: _textController,
                onSubmitted: (b) =>
                    _handleSubmitted(_textController.text, false),
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text, false),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _textComposerWidget(),
        ),
        /*StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("chat").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //i++;
                 _handleSubmitted("dede", true);
                 return Container();
                //return Text("i =  " + i.toString() + "  i2 =  " + i2.toString());
              }
            }),
        new Text("i =  " + i.toString() + "  i2 =  " + i2.toString()),*/
      ],
    );
  }
}
