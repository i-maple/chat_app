import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/components/rounded_button.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const routeId = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flash ',
                style: kLargeText,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Chat⚡️',
                      speed: Duration(milliseconds: 400),
                      textStyle: kLargeText.copyWith(color: Colors.amber[700])),
                ],
              ),
            ],
          ),
          RoundedButtonWidget(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.routeId,
                  arguments: null);
            },
            text: 'Log In',
            color: Colors.lightBlue[900],
            isText: true,
          ),
          Text("OR", style: kLargeText),
          RoundedButtonWidget(
            isText: true,
            onTap: () {
              Navigator.pushNamed(context, RegistrationScreen.routeId,
                  arguments: null);
            },
            text: 'Register',
            color: Colors.amber[700],
          )
        ],
      ),
    );
  }
}
