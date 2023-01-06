import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textcolor;
  final String buttonText;
  final buttenTapped;

  MyButton({this.color, this.textcolor, required this.buttonText, this.buttenTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttenTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
              child: Center(child: Text(buttonText, style: TextStyle(color: textcolor),),)
          ),
        ),
      ),
    );
  }
}