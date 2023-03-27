import 'package:flame/components.dart';
import 'package:flame_dgs_assigment/constants/globals.dart';
import 'package:flame_dgs_assigment/game/flappy_bird_game.dart';

class PlayerComponent extends SpriteAnimationComponent
    with HasGameRef<FlappyBirdGame> {
  final spriteSize = Vector2(270, 185);
  final double _speed = 200;

  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  JoystickComponent joystick;

  PlayerComponent({required this.joystick});

  get images => null;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    var spriteSheet = await images.load(Global.spriteSheet);

    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 4, stepTime: 0.3, textureSize: Vector2(270.0, 185.0));
    SpriteAnimationComponent animation =
        SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData);

    animation
      ..position = gameRef.size / 2
      ..size = spriteSize
      ..anchor = Anchor.center;
    this.animation = animation.animation;

    _rightBound = gameRef.size.x - 45;
    _leftBound = 45;
    _upBound = 45;
    _downBound = gameRef.size.y - 50;
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

    position += joystick.relativeDelta * _speed * dt;
  }
}
