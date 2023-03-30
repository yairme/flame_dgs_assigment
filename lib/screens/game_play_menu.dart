import 'package:flame/game.dart';
import 'package:flame_dgs_assigment/game/flappy_bird_game.dart';
import 'package:flame_dgs_assigment/screens/game_over_menu.dart';
import 'package:flutter/widgets.dart';

final FlappyBirdGame _fallpyBirdGame = FlappyBirdGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _fallpyBirdGame,
      overlayBuilderMap: {
        GameOverMenu.ID: (BuildContext context, FlappyBirdGame gameRef) =>
            GameOverMenu(gameRef: gameRef),
      },
    );
  }
}
