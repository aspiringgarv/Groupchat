import 'package:fcc/screens/login_screen.dart';
import 'package:fcc/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:fcc/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fcc/screens/buttons.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = 'ws';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    
    super.initState();
    controller = AnimationController(
      vsync: this,
    duration:Duration(seconds: 1),
    );
    animation = /*CurvedAnimation(parent: controller, curve:Curves.decelerate);*/ColorTween(
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(controller);
    controller.forward();
    /*controller.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        controller.reverse(from: 1);     /*inf loop transition*/
      }
      else if(status==AnimationStatus.dismissed){
        controller.forward();
      }
    });*/
    controller.addListener(() {
      setState(() {

      });
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'one',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(

                    'Flash Chat',
                   textStyle:TextStyle(
                      fontSize: 44.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],

                ),
              ],
            ),
            RoundedButton(text: 'Login',onpressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },m: Colors.blue),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(text: 'Register',onpressed:(){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },m: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}

