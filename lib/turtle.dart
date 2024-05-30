import 'package:flutter/material.dart';

class MyTurtle extends StatelessWidget {
  const MyTurtle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Image.asset(
      'lib/images/turtle.png',
      )
    );
  }
}