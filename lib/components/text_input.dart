import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  TextInputWidget(
      {required this.onChanged,
      required this.hintText,
      required this.icon,
      required this.isPassword, this.controller});
  final String hintText;
  final icon;
  final bool isPassword;
  final Function(String value) onChanged;
  var controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        onChanged: onChanged,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(hintText),
          labelStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
          icon: Icon(
            icon,
            color: Colors.blue,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
