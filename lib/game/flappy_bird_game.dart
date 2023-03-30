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
import 'package:flutter/material.dart';

import '../BloC/flappy_bird_bloc.dart';
import '../screens/game_over_menu.dart';

class FlappyBirdGame extends FlameGame
    with HasDraggables, HasCollisionDetection {
  late PlayerComponent player = PlayerComponent(joystick: joystick);
  late BackgroundComponent backgroundComponent = BackgroundComponent();
  late CornComponent corn = CornComponent();

  late FlappyBirdBloc gameBloc;

  late TextComponent _scoreText;
  late TextComponent _timeText;

  int score = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    FlameAudio.bgm.play(Global.backgroundMusic);

    add(backgroundComponent);

    add(corn);

    add(player);

    add(joystick);

    FlameAudio.audioCache.loadAll([
      Global.itemGrabSound,
      Global.obsticleHitSound,
    ]);

    add(ObsticleComponent(startPosition: Vector2(200, 200)));
    add(ObsticleComponent(startPosition: Vector2(size.x - 200, size.y - 200)));

    add(ScreenHitbox());

    gameBloc = FlappyBirdBloc();

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

    gameBloc.stream.listen((state) {
      score = state.score;
      _scoreText.text = 'Score: ${state.score}';
      _timeText.text = 'Time: ${state.remainingTime} seconds';

      if (state.isGameOver) {
        pauseEngine();
        FlameAudio.bgm.stop();
        FlameAudio.play(Global.gameOver);
        overlays.add(GameOverMenu.ID);
        return;
      }
    });

    gameBloc.add(StartGameEvent());
  }
}
