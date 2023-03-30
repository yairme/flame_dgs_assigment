import 'package:flame/game.dart';
import 'package:flame_dgs_assigment/game/flappy_bird_game.dart';
import 'package:flame_dgs_assigment/screens/game_over_menu.dart';
import 'package:flutter/widgets.dart';

// Instantiate a new instance of the FlappyBirdGame class
final FlappyBirdGame _fallpyBirdGame = FlappyBirdGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _fallpyBirdGame,

      // Map of overlay IDs to overlay builder functions
      overlayBuilderMap: {
        GameOverMenu.ID: (BuildContext context, FlappyBirdGame gameRef) =>
            GameOverMenu(gameRef: gameRef),
      },
    );
  }
}
