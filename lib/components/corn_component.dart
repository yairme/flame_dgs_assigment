import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_dgs_assigment/BloC/flappy_bird_bloc.dart';
import 'package:flame_dgs_assigment/components/player_component.dart';
import 'package:flame_dgs_assigment/constants/globals.dart';
import 'package:flame_dgs_assigment/game/flappy_bird_game.dart';

class CornComponent extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  final double _spriteHeight = 100;
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Global.itemSprite);
    height = width = _spriteHeight;
    position = _getRandomPosition();
    anchor = Anchor.center;

    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlayerComponent) {
      FlameAudio.play(Global.itemGrabSound);

      removeFromParent();

      // Get the current state from the game's bloc
      final currentState = gameRef.gameBloc.state;

      // Check if the game is over or not
      if (!currentState.isGameOver) {
        // Add score to the bloc if the game is not over
        gameRef.gameBloc.add(ScoreUpdateEvent(1));

        // Add a new CornComponent
        gameRef.add(CornComponent());
      }
    }
  }

  Vector2 _getRandomPosition() {
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }
}
