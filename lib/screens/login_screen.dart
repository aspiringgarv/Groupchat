import 'package:fcc/screens/chat_screen.dart';
import 'package:fcc/screens/enteringscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import 'buttons.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'ls';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  {
  final _auth = FirebaseAuth.instance;
  String email="";
  String pass="";
  bool spinning  = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinning,
        child:
        Padding(
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
                hintText: 'Enter your Email'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
                pass = value;
              },
              decoration: kTextFieldDecorations.copyWith(
                hintText: 'Enter Your Password'
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(m: Colors.blueAccent,onpressed: ()async{
              setState(() {
                spinning=true;
              });
             try{
               final user = await _auth.signInWithEmailAndPassword(email: email, password: pass);
               if(user!=null){
                 Navigator.pushNamed(context, entering.id);
               }
               setState(() {
                 spinning=false;
               });
             }
             catch(e){
               setState(() {
                 spinning=false;
                 ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                   content: Text(e.toString()),
                 ));
               });
             }
            },text: 'Login'),
          ],
        ),
      ),
      ),
    );
  }
}
