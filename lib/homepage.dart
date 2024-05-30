import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turtlegame/turtle.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static double turtleYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = turtleYaxis;
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * (time * time) + 2.8 * time;
      setState(() {
        turtleYaxis = initialHeight - height;
      });

      if (turtleYaxis > 0.85) {
        setState(() {
          timer.cancel();
          gameHasStarted = false;
        });
      }
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = turtleYaxis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 5,
          child: GestureDetector(
            onTap: () {
              if (gameHasStarted) {
                jump();
              } else {
                startGame();
              }
            },
            child: AnimatedContainer(
              alignment: Alignment(-0.7, turtleYaxis),
              duration: Duration(milliseconds: 0),
              color: Colors.blue[900],
              child: MyTurtle(),
            ),
          ),
        ),
        SizedBox(
          height: 15,
          child: Image.asset(
            'lib/images/lixo.jpg',
            // Estica a imagem para preencher a largura da tela
            width: double.infinity,
            // Mantém a proporção da imagem
            fit: BoxFit.fill,
            
          ),
        ),
        Expanded(
          child: Container(
              color: Colors.brown,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pontuação',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Melhor',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '10',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ]),
    );
  }
}
