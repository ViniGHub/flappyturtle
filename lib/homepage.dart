import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:turtlegame/barriers.dart';
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
  bool gameover = false;
  int score = 0;
  int bestscore = 0;

  static double barrier1Xaxis = 1;
  double barrier2Xaxis = barrier1Xaxis + 1.5;

  double barrier1Size = 200.0;
  double barrier2Size = 100.0;

  void startGame() {
    setState(() {
      gameHasStarted = true;
    });

    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * (time * time) + 2.8 * time;
      if (barrier1Xaxis < -1.7) {
        barrier1Xaxis = 2.2;
        barrier1Size = 50 + Random().nextDouble() * 300;
        score++;
      }
      if (barrier2Xaxis < -1.7) {
        barrier2Xaxis = 2.2;
        barrier2Size = 50 + Random().nextDouble() * 300;
        score++;
      }

      setState(() {
        barrier1Xaxis -= 0.05;
        barrier2Xaxis -= 0.05;
        turtleYaxis = initialHeight - height;
      });

      if (turtleYaxis > 1.05) {
        setState(() {
          timer.cancel();
          turtleYaxis = 1.05;
          gameover = true;
          gameHasStarted = false;

          if (score > bestscore) {
            bestscore = score;
          }
        });
      }
    });
  }

  void reset() {
    setState(() {
      time = 0;
      turtleYaxis = 0;
      initialHeight = turtleYaxis;
      barrier1Xaxis = 1;
      barrier2Xaxis = barrier1Xaxis + 1.5;
      barrier1Size = 200.0;
      barrier2Size = 100.0;
      gameover = false;
      score = 0;
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
              if (!gameover) {
                if (gameHasStarted) {
                  jump();
                } else {
                  startGame();
                }
              } else {
                reset();
              }
            },
            child: Stack(
              children: [
                AnimatedContainer(
                  alignment: Alignment(-0.7, turtleYaxis),
                  duration: const Duration(milliseconds: 0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/fundo.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const MyTurtle(),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrier1Xaxis, 1.1),
                  duration: const Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: barrier1Size,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrier1Xaxis, -1.1),
                  duration: const Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 400 - barrier1Size,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrier2Xaxis, 1.1),
                  duration: const Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: barrier2Size,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrier2Xaxis, -1.1),
                  duration: const Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 400 - barrier2Size,
                  ),
                ),
                Container(
                  alignment: const Alignment(0, -0.5),
                  child: gameHasStarted
                      ? const Text('')
                      : const Text(
                          'CLIQUE PARA JOGAR',
                          style: TextStyle(
                            letterSpacing: 7,
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Pontuação',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      score.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Melhor',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      bestscore.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
