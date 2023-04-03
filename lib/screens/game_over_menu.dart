import 'package:flame_dgs_assigment/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';
import '../bloc/flappy_bird_bloc.dart';

class GameOverMenu extends StatelessWidget {
  // Identifier for the overlay menu
  // ignore: constant_identifier_names
  static const ID = 'GameOverMenu';

  // The current game instance
  final FlappyBirdGame gameRef;

  const GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final Size screenSize = MediaQuery.of(context).size;

    // Calculate the scale based on the screen width
    const double referenceScreenWidth = 375;
    final double scale = screenSize.width / referenceScreenWidth;

    // Calculate the font size based on the scale
    final double fontSize = 48 * scale;

    // Build the UI for the game over menu
    return Scaffold(
      body: Stack(
        children: [
          // Add a black background
          Container(
            color: Colors.black, // set background color here
          ),

          // Add the UI elements
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add the game over text
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

              // Add the score text
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

              // Add the reset button
              SizedBox(height: 32 * scale),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Remove the game over menu from the overlays
                      gameRef.overlays.remove(GameOverMenu.ID);

                      // Add a reset event to the game's bloc
                      gameRef.gameBloc.add(ResetEvent());

                      // Resume the game engine
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
