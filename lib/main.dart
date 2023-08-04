import 'package:fcc/screens/chat_screen.dart';
import 'package:fcc/screens/enteringscreen.dart';
import 'package:fcc/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fcc/screens/welcome_screen.dart';
import 'package:fcc/screens/registration_screen.dart';
import 'package:fcc/screens/enteringscreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // This is the last thing you need to add.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'ws',
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),  //we can do this also
        entering.id:(context)=>entering(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        ChatScreen.id:(context)=>ChatScreen(),
      },
    );
  }
}
