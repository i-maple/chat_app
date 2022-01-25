import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RoundedButtonWidget extends StatelessWidget {
  RoundedButtonWidget({required this.onTap, required this.text, this.color, required this.isText});

  final bool isText;
  final VoidCallback onTap;
  final String text;
  final color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
        margin: EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color,
        ),
        child: isText? Text(
          text,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        ): SpinKitRing(color: Colors.white, size: 15.0,),
      ),
      onTap: onTap,
    );
  }
}
