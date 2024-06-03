import 'dart:ui';

import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  double size;
  MyBarrier({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/barreira.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}