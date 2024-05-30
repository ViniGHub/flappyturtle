import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  const MyBarrier({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 300,
      color: Colors.green[800],
      child: Image.asset(
        'lib/images/barrier.png',
      ),
    );
  }
}