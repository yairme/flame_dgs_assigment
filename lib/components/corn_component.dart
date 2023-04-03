import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_dgs_assigment/bloc/flappy_bird_bloc.dart';
import 'package:flame_dgs_assigment/components/player_component.dart';
import 'package:flame_dgs_assigment/constants/globals.dart';
import 'package:flame_dgs_assigment/flappy_bird_game.dart';

class CornComponent extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  // Define the height of the sprite and a random number generator
  final double _spriteHeight = 100;
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the corn sprite and set its height and width
    sprite = await gameRef.loadSprite(Global.itemSprite);
    height = width = _spriteHeight;

    // Set the position of the corn component to a random position on the game screen
    position = _getRandomPosition();

    // Set the anchor to the center of the sprite
    anchor = Anchor.center;

    // Add a circle hitbox to the corn component for collision detection
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // Check if the other component colliding with the corn component is the player
    if (other is PlayerComponent) {
      // Play the sound effect for grabbing the corn
      FlameAudio.play(Global.itemGrabSound);

      // Remove the corn component from the game
      removeFromParent();

      // Get the current state from the game's bloc
      final currentState = gameRef.gameBloc.state;

      // Check if the game is over or not
      if (!currentState.isGameOver) {
        // Add score to the bloc if the game is not over
        gameRef.gameBloc.add(ScoreUpdateEvent(1));

        // Add a new CornComponent to the game
        gameRef.add(CornComponent());
      }
    }
  }

  // Generates a random position for the corn component within the game screen
  Vector2 _getRandomPosition() {
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }
}
