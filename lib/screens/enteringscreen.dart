import 'dart:collection';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fcc/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class entering extends StatefulWidget {
  const entering({super.key});
  static String id = 'enteringscreen';
  @override
  State<entering> createState() => _enteringState();
}

class _enteringState extends State<entering> with SingleTickerProviderStateMixin {
  late AnimationController a;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async {
        bool willLeave = false;
        await Alert(
          context: context,
          type: AlertType.warning,
          title: ">Do you want to Logout<",
          desc: "Do You Want To Leave",
          buttons: [
            DialogButton(
              child: Text(
                "COOL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                willLeave = true;
                _auth.signOut();
                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
        return willLeave;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(55, 178, 139, 0.8509803921568627),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Horizon'
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1500000,
                    animatedTexts: [
                      TypewriterAnimatedText('Lets go to the group chat All are waiting'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    child: Icon(
                        color: Colors.yellowAccent,Icons.arrow_forward_ios_rounded),
                    onPressed: (){
                     Navigator.popAndPushNamed(context, ChatScreen.id);
                    },
                    shape: CircleBorder(side: BorderSide(color: Colors.lightBlue), eccentricity: 1),
                    backgroundColor: Colors.amberAccent,
                    splashColor: Colors.yellowAccent,
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}


