import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_dgs_assigment/components/Corn_component.dart';
import 'package:flame_dgs_assigment/components/background_component.dart';
import 'package:flame_dgs_assigment/components/obsticle_component.dart';
import 'package:flame_dgs_assigment/components/player_component.dart';
import 'package:flame_dgs_assigment/constants/globals.dart';
import 'package:flame_dgs_assigment/inputs/joystick_component.dart';
import 'package:flame_dgs_assigment/Decorator/decorator_component.dart';
import 'package:flutter/material.dart';

import '../BloC/flappy_bird_bloc.dart';
import '../screens/game_over_menu.dart';

/// A class representing the main game logic and components of the Flappy Bird game.
class FlappyBirdGame extends FlameGame
    with HasDraggables, HasCollisionDetection {
  late PlayerComponent player = PlayerComponent(joystick: joystick);
  late BackgroundComponent backgroundComponent = BackgroundComponent();
  late CornComponent corn = CornComponent();
  late Decorator decorator = Decorator();

  late FlappyBirdBloc gameBloc;

  late TextComponent _scoreText;
  late TextComponent _timeText;

  int score = 0;

  /// Called when the game is loaded.
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    FlameAudio.bgm.play(Global.backgroundMusic);

    add(backgroundComponent);

    add(decorator);

    add(corn);

    add(player);

    add(joystick);

    // Load sounds used in the game
    FlameAudio.audioCache.loadAll([
      Global.itemGrabSound,
      Global.obsticleHitSound,
    ]);

    // Add obstacles to the game
    add(ObsticleComponent(startPosition: Vector2(200, 200)));
    add(ObsticleComponent(startPosition: Vector2(size.x - 200, size.y - 200)));

    add(ScreenHitbox());

    // Set up game logic using the FlappyBirdBloc class
    gameBloc = FlappyBirdBloc();

    // Set up score text
    _scoreText = TextComponent(
      text: 'Score: ${gameBloc.state.score}',
      position: Vector2(40, 40),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.black.color,
          fontSize: 50,
        ),
      ),
    );
    add(_scoreText);

    // Set up remaining time text
    _timeText = TextComponent(
      text: 'Time: ${gameBloc.state.remainingTime} seconds',
      position: Vector2(size.x - 40, 40),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.black.color,
          fontSize: 50,
        ),
      ),
    );
    add(_timeText);

    // Listen to changes in game state and update UI accordingly
    gameBloc.stream.listen((state) {
      score = state.score;
      _scoreText.text = 'Score: ${state.score}';
      _timeText.text = 'Time: ${state.remainingTime} seconds';

      // If game is over, pause the engine, stop background music, play game over sound effect,
      // and show the game over menu overlay.
      if (state.isGameOver) {
        pauseEngine();
        FlameAudio.bgm.stop();
        FlameAudio.play(Global.gameOver);
        overlays.add(GameOverMenu.ID);
        return;
      }
    });

    // Start the game by adding a StartGameEvent to the game
    gameBloc.add(StartGameEvent());
  }
}
