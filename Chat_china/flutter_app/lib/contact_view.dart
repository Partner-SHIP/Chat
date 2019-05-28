import 'package:flutter/material.dart';
import 'contact_data.dart';
import 'package:flutter_app/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';

class ScreenArguments {
  String title;
  String message;
  String conversation;

  ScreenArguments(this.title, this.message, this.conversation);
}

class _ContactListItem extends StatelessWidget {
  String title, subtitle, conversation, documentID;

  _ContactListItem(
      this.title, this.subtitle, this.conversation, this.documentID);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.title),
      subtitle: Text(subtitle),
      leading: CircleAvatar(child: Text(this.title)),
      onTap: () {
        convMembers.dest = this.documentID;
        print(convMembers.dest);
        conversations_path =
            "chat/" + authID + "/conversations/" + this.documentID;
        this.conversation = conversations_path;
        Navigator.pushNamed(context, ExtractArgumentsScreen.routeName,
            arguments:
                ScreenArguments(this.title, this.subtitle, conversations_path));
      },
    );
  }
}

class ContactList extends StatelessWidget {
  final List<Contact> _contacts;
  final String conversation;

  ContactList(this._contacts, this.conversation);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return _ContactListItem(
            _contacts[index].fullName,
            _contacts[index].message,
            this.conversation,
            _contacts[index].documentID);
      },
      itemCount: _contacts.length,
    );
  }

  List<_ContactListItem> _buildContactList() {
    return _contacts
        .map((contact) => _ContactListItem(contact.fullName, contact.message,
            this.conversation, contact.documentID))
        .toList();
  }
}

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactsPageState();
  }
}

class ContactsPageState extends State<ContactsPage> {
  String conversations_list_path_db;
  String userID;

  @override
  void initState() {
    authID = "2BnUJzrEIHgQ26yK77woczoAWMQ2";
    convMembers.send = authID;
    //userID = FirebaseAuth.instance.currentUser();
    conversations_path = "chat/" + authID + "/conversations";
    conversations_list_path_db = conversations_path;
  }

  void setConversationsList(List<DocumentChange> conversations) {
    conversations.forEach((conversation) {
      Firestore.instance
          .collection("profiles")
          .document(conversation.document.documentID)
          .snapshots()
          .listen((onData) {
        setState(() {
          kContacts.add(Contact(
              fullName: onData.data["nickname"],
              message: "",
              documentID: conversation.document.documentID));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(conversations_list_path_db).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasError &&
            snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          if (snapshot.data.documents.length > kContacts.length)
            setConversationsList(snapshot.data.documentChanges);
          snapshot.data.documentChanges.forEach((f) {
            if (f.type != DocumentChangeType.removed && kContacts.length > 0) {
              List messages = f.document.data["messages"];
              kContacts[kContacts.indexWhere((contacts) =>
                      contacts.documentID == f.document.documentID)]
                  .message = messages.last["message"];
            }
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: new Text("Conversations"),
          ),
          body: ContactList(kContacts, conversations_list_path_db),
          floatingActionButton: FloatingActionButton(
              child: Text('New'),
              onPressed: () => Navigator.of(context).pushNamed('/NewConv')),
        );
      },
    );
  }
}
