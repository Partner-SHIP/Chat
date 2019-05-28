import 'package:flutter/material.dart';
import 'contact_data.dart';
import 'package:flutter_app/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';
import 'chat_screen.dart';
import 'contact_view.dart';

class NewContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Contacts"),
        ),
        body: new Contact2());
  }
}

class Contact2 extends StatefulWidget {
  @override
  State createState() => new ContactListN(/*kContacts*/);
}

class ContactListN extends State<Contact2> {
  List<Member> members = new List();
  int i = 0;

  // ContactListN();

  @override
  void initState() {
    // TODO: implement initState
    Firestore.instance.collection('profiles').getDocuments().then((onValue) {
      onValue.documents.forEach((f) {
        setState(() {
          if (f.data['nickname'] != null) {
            members.add(Member(
                fullName: f.data['nickname'], email: '', uid: f.data['uid']));
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return new _ContactListItemN(members[index], context);
      },
      itemCount: members.length,
    );
  }
}

class _ContactListItemN extends ListTile {
  _ContactListItemN(Member member, BuildContext context)
      : super(
            title: new Text(member.fullName),
            subtitle: new Text(member.email),
            onTap: () {
              convMembers.dest = authID;
              convMembers.send = member.uid;
              conversations_path =
                  "chat/" + authID + "/conversations/" + member.uid;
              print("TEST    " + conversations_path);
              Navigator.pushNamed(
                  context, ExtractArgumentsScreen.routeName,
                  arguments:
                  ScreenArguments(member.fullName, "", conversations_path)
              );
            },
            leading: new CircleAvatar(child: new Text(member.fullName[0])));
}

class Member {
  final String fullName;
  final String email;
  final String uid;

  const Member({this.fullName, this.email, this.uid});
}
