import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(MaterialApp(
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.white
    ),
    initialRoute: WelcomeScreen.routeId,
    routes: {
      WelcomeScreen.routeId : (context)=>const WelcomeScreen(),
      LoginScreen.routeId : (context)=>const LoginScreen(),
      RegistrationScreen.routeId: (context)=>const RegistrationScreen(),
      ChatScreen.routeId: (context)=>const ChatScreen()
    },
  ));

    await Firebase.initializeApp();
}
