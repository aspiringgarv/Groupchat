import 'package:fcc/constants.dart';
import 'package:fcc/screens/buttons.dart';
import 'package:fcc/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class RegistrationScreen extends StatefulWidget {
  static const String id = 'rs';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;/*authentication private instance*/
  String email="";
  String pass="";
  bool showspinner =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:ModalProgressHUD( 
      inAsyncCall: showspinner,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'one',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email=value;
              },
              decoration: kTextFieldDecorations.copyWith(
                hintText: 'Enter Your Email'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                pass = value;
              },
              decoration: kTextFieldDecorations.copyWith(
                     hintText: 'Enter Your Password'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(m: Colors.blueAccent,onpressed: () async {
              // print(email);
              // print(pass);
              setState(() {
                showspinner=true;
              });
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: pass);
                if(newUser!=null){
                  setState(() {
                    showspinner=false;
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      elevation: 10,
                      backgroundColor: Colors.blue,
                      content: Text("registered successfully => plz login to continue",style: TextStyle(color: Colors.black87),),
                    ));
                  });
                }
                setState(() {
                  showspinner=false;
                });
              }/*if user enter any password and email already registered */
              catch(e){
               setState(() {
                 showspinner=false;
                 ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                   content: Text(e.toString()),
                 ));
               });
              }

              },text: 'Register'),
          ],
        ),
      ),
      ),
    );
  }
}
