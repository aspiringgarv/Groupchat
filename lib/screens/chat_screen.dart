import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fcc/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:cloud_firestore/cloud_firestore.dart';
final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'cs';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  String messagetext = '';
  final messagetest = TextEditingController();
  User? loggedinuser;
  void getcurruser()async {
    try{
      final user = await _auth.currentUser;
      if(user!=null){
        loggedinuser=user;

      }

    }
    catch(e){
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(e.toString()),
        ));
      });
    }

  }
  // void getmessages()async{
  //   final messages = await _firestore.collection('messages').get();
  //   for(var message in messages.docs){
  //     print(message.data());
  //   }
  // }
  Future<void> getstreams() async {

    await for(var snap in _firestore.collection('messages').snapshots()){
      for( var message in snap.docs){
        print(message.data());
      }
    }
  }
  String? getemail(){
    if(loggedinuser!=null){
      return loggedinuser?.email;
    }
    return "";
  }
  @override
  void initState() {
    // TODO: implement initState
    getcurruser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           MessageStream(loggedinuser: getemail()),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetest,
                      onChanged: (value) {
                        //Do something with the user input.

                        messagetext=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messagetest.clear();
                      _firestore.collection('messages').add({
                        'text':messagetext,
                        'sender':loggedinuser?.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
final String sender;
final String text;
final bool isme;
MessageBubble({required this.sender,required this.text,required this.isme});

@override
  Widget build(BuildContext context) {


    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isme?CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',
      style: TextStyle(fontSize: 12,color: Colors.black),),
          Material(
            elevation: 10,
shadowColor: Colors.white30,
            borderRadius: isme?BorderRadius.only(
                bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30),topLeft: Radius.circular(30),):BorderRadius.only(
              bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30),topRight: Radius.circular(30),),
            color: isme?Colors.blueAccent:Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$text',
                style: TextStyle(fontSize: 15.0)),
              ),
          ),
        ],
      ),
    );

  }
}
class MessageStream extends StatelessWidget {
  final String? loggedinuser;
   MessageStream({required this.loggedinuser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData==false){
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
        final messages = snapshot.data?.docs.reversed;
        List<MessageBubble> messagewid = [];
        for(var message in messages!){
          final messagedata = message.get('text');

          final messagesender = message.get('sender');
          final messagewidget = MessageBubble(sender: messagesender, text: messagedata, isme: loggedinuser==messagesender);


          messagewid.add(messagewidget);
        }
        return Expanded(child:ListView(
          reverse: true,
          padding: EdgeInsets.symmetric(),
          children: messagewid,
        ),);
      },
    );
  }
}

