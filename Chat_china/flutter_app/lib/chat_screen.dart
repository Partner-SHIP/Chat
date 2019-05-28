import 'package:flutter/material.dart';
import 'package:flutter_app/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'contact_data.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
   //       title: new Text("Contacts"),
        ),
        body: new ChatScreen("test", conversations_path));
  }
}

class ChatScreen extends StatefulWidget {
  String name;
  String conversation;

  ChatScreen(this.name, this.conversation);

  @override
  State createState() => new ChatScreenState(this.name, this.conversation);
}

class ChatScreenState extends State<ChatScreen> {
  String _name;
  String destName;
  String conversation;
  String dest_path;

  ChatScreenState(this.destName, this.conversation);

  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void initState() {
    // TODO: implement initState
    Text text;

    dest_path =
        "chat/" + convMembers.send + "/conversations/" + convMembers.dest;
    print(dest_path);

  Firestore.instance.collection('profiles').getDocuments().then((onValue) {
      onValue.documents.forEach((f){
        if (f.data['nickname'] != null && f.data['uid'] == authID) {
          setState(() {
            _name = f.data['nickname'];
          });
        }
      });

    });
 // _name = "test";
    super.initState();
  }

  void _handleSubmitted(String text, String date) {
    if (text != null && text.length > 0) {
      _textController.clear();
      ChatMessage message = new ChatMessage(
        name: _name,
        text: text,
        date: date,
      );
      _messages.insert(0, message);
    }
  }

  void _sendMessage(String text) {
    Map<String, dynamic> map = {
      'name': _name,
      'message': text,
      'timestamp': DateTime.now(),
      'hasSeen': false
    };

    Map<String, dynamic> destMap = {
      'name': destName,
      'message': text,
      'timestamp': DateTime.now(),
      'hasSeen': false
    };
    Firestore.instance.document(this.conversation).setData({
      'messages': FieldValue.arrayUnion([map])
    }, merge: true);
    Firestore.instance.document(dest_path).setData({
      'messages': FieldValue.arrayUnion([destMap])
    }, merge: true);
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
                onSubmitted: _sendMessage,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _sendMessage(_textController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.document(this.conversation).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasError &&
            snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData && snapshot.data.data != null) {
          if (snapshot.data.data.containsValue("messages") != null) {
            List list = snapshot.data.data["messages"];
            if (list != null) var value = list.last["message"];
            if (list != null && _messages.length < list.length && _name != null) {
              for (int i = _messages.length; i < list.length; i++) {
                DateTime dateTime = list.elementAt(i)["timestamp"];
                _handleSubmitted(list.elementAt(i)["message"].toString(),
                    dateTime.toString());
              }
            }
          }
        }
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
          ],
        );
      },
    );
  }
}
