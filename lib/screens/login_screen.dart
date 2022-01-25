import 'package:chat_app/components/rounded_button.dart';
import 'package:chat_app/components/text_input.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeId = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;
  String textString = 'Login Screen';
  bool isText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textString,
                style: kLargeText,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextInputWidget(
                isPassword: false,
                onChanged: (value) {
                  email = value;
                },
                hintText: 'Email',
                icon: Icons.email,
              ),
              TextInputWidget(
                  onChanged: (value) {
                    password = value;
                  },
                  isPassword: true,
                  hintText: 'Password',
                  icon: Icons.password),
              RoundedButtonWidget(
                isText: isText,
                onTap: () async {
                 setState(() {
                    isText = false;
                 });
                  var loginUser = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  try {
                    Navigator.pushNamed(context, ChatScreen.routeId,
                        arguments: loginUser);
                    setState(() {
                      isText = true;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                text: 'Log In',
                color: Colors.lightBlue[900],
              )
            ],
          ),
        ),
      ),
    );
  }
}
