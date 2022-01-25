import 'package:chat_app/components/rounded_button.dart';
import 'package:chat_app/components/text_input.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeId = 'registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  bool isText = true;
  String password = '';
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Registration Screen',
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
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    try {
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.routeId,
                            arguments: newUser);
                      }
                      setState(() {
                      isText = true;
                    });
                      isText = false;
                    } catch (e) {
                      print(e);
                    }
                  },
                  text: 'Register',
                  color: Colors.amber[700],
                )
              ],
            ),
          ),
        ),
    );
  }
}
