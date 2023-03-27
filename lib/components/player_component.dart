import 'package:flame/components.dart';
import 'package:flame_dgs_assigment/constants/globals.dart';
import 'package:flame_dgs_assigment/game/flappy_bird_game.dart';
import 'package:flutter/widgets.dart';

class PlayerComponent extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  final double _spriteHeight = 200;
  final double _speed = 200;

  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  JoystickComponent joystick;

  PlayerComponent({required this.joystick});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Global.playerSprite);

    _rightBound = gameRef.size.x - 45;
    _leftBound = 45;
    _upBound = 45;
    _downBound = gameRef.size.y - 50;

    position = gameRef.size / 2;
    height = _spriteHeight;
    width = _spriteHeight * 1.45;
  }

  @override
  void update(dt) {
    super.update(dt);

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

    position.add(joystick.relativeDelta * _speed * dt);
  }
}
