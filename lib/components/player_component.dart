import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_dgs_assigment/components/obsticle_component.dart';
import 'package:flame_dgs_assigment/constants/globals.dart';
import 'package:flame_dgs_assigment/flappy_bird_game.dart';
import 'package:flame_dgs_assigment/particles/particle_system.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flutter/material.dart';

// Define the PlayerComponent class
class PlayerComponent extends SpriteAnimationComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  final spriteSize = Vector2(250, 200);
  final double _speed = 300;

  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  JoystickComponent joystick;

  late SpriteAnimation stunAnim;
  late SpriteAnimation animLeft;
  late SpriteAnimation animRight;

  // Constructor for PlayerComponent
  PlayerComponent({required this.joystick});

  bool _hitStun = false;
  final Timer _timer = Timer(3);

  // Override the onLoad method to load the player sprite sheet and animations
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the player sprite sheet from a JSON atlas file
    List<Sprite> spriteSheet =
        await gameRef.fromJSONAtlas(Global.spriteSheet, 'spriteSheet.json');

    // Create sprite animations for the different movement states of the player
    stunAnim = SpriteAnimation.spriteList(
      [await gameRef.loadSprite(Global.stunPlayer)],
      stepTime: 0.1,
      loop: true,
    );

    animLeft = SpriteAnimation.spriteList(
      spriteSheet.sublist(0, 4),
      stepTime: 0.1,
      loop: true,
    );

    animRight = SpriteAnimation.spriteList(
      spriteSheet.sublist(4, 8),
      stepTime: 0.1,
      loop: true,
    );

    // Set the initial position and size of the player
    position = gameRef.size / 2;
    height = spriteSize.y;
    width = spriteSize.x;
    anchor = Anchor.center;

    // Set the initial movement state of the player
    animation = animLeft;

    // Set the boundaries for the player's movement
    _rightBound = gameRef.size.x - 45;
    _leftBound = 45;
    _upBound = 45;
    _downBound = gameRef.size.y - 45;

    // Add a hitbox for the player
    add(CircleHitbox());
  }

  // Override the update method to handle player movement and animation
  @override
  void update(dt) {
    super.update(dt);
    // If the player is not stunned, handle joystick input for movement and animation
    // This if statement checks if the player is not in a hit stun state and if so, handles joystick input for movement and animation.
    if (!_hitStun) {
      if (joystick.direction == JoystickDirection.idle) {
        animation = animRight;
        return;
      }

      // These four if statements ensure the player doesn't move out of bounds by setting their position to be within the bounds.
      if (x >= _rightBound) {
        x = _rightBound - 1;
      }

      if (x <= _leftBound) {
        x = _leftBound + 1;
      }

      if (y >= _downBound) {
        y = _downBound - 1;
      }

      if (y <= _upBound) {
        y = _upBound + 1;
      }

      // This boolean variable stores whether the player is moving left or not.
      bool movingLeft = joystick.relativeDelta[0] < 0;

      // Get's the relative Delta of the Jostick, to apply it to the Vector2 direction.
      Vector2 direction = joystick.relativeDelta;
      // This if-else block sets the current animation based on the direction the player is moving.
      if (movingLeft) {
        animation = animLeft;
      } else {
        animation = animRight;
      }

      // This line updates the player's position based on joystick input, speed, and the elapsed time since the last frame.
      position += joystick.relativeDelta * _speed * dt;

      // Creates a ParticleSystemComponet where it has a MovingParticle that moves a CircleParticle that is created here.
      gameRef.add(MyParticleSystem()
          .circleParticle(position, direction, Paint()..color = Colors.black));
    } else {
      // If the player is in a hit stun state, update the stun timer.
      _timer.update(dt);
      if (_timer.finished) {
        // If the stun timer has finished, unstun the player.
        _unStunPlayer();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
// If the player collides with an obstacle, stun the player.
    if (other is ObsticleComponent) {
      _stunPlayer();
    }
  }

// This method unstuns the player by setting the hit stun flag to false and changing the animation to the default state.
  void _unStunPlayer() {
    _hitStun = false;
    animation = animRight;

    add(
      ColorEffect(
        const Color.fromARGB(0, 255, 255, 255),
        const Offset(0.0, 0.0),
        EffectController(duration: 1.5),
      ),
    );
  }

// This method stuns the player by setting the hit stun flag to true, changing the animation to the stun state, and starting the stun timer.
  void _stunPlayer() {
    if (!_hitStun) {
      FlameAudio.play(Global.obsticleHitSound);
      FlameAudio.play(Global.obsticleHitSound);

      _hitStun = true;

      animation = stunAnim;

      add(
        ColorEffect(
          const Color.fromARGB(255, 255, 0, 0),
          const Offset(0.0, 0.4),
          EffectController(duration: 1.5),
        ),
      );

      _timer.start();
    }
  }
}
