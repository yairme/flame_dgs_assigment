import 'package:flame_dgs_assigment/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';
import '../BloC/flappy_bird_bloc.dart';

class GameOverMenu extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ID = 'GameOverMenu';
  final FlappyBirdGame gameRef;

  const GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    const double referenceScreenWidth = 375;
    final double scale = screenSize.width / referenceScreenWidth;
    final double fontSize = 48 * scale;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black, // set background color here
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Game Over',
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20 * scale),
              Expanded(
                child: Center(
                  child: Text(
                    'Score: ${gameRef.score}',
                    style: TextStyle(
                      fontSize: 24 * scale,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32 * scale),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(GameOverMenu.ID);
                      gameRef.gameBloc.add(ResetEvent());
                      gameRef.resumeEngine();
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(200 * scale, 60 * scale)),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 24 * scale / 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
