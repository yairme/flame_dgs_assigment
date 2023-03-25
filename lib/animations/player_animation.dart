import 'package:flame/components.dart';
import 'package:flame_dgs_assigment/games/flappy_bird_game.dart';

import '../constants/globals.dart';

class PlayerAnimation extends SpriteAnimationComponent
    with HasGameRef<FlappyBirdGame> {
  SpriteAnimationData spritedata = SpriteAnimationData.sequenced(
      amount: 4, stepTime: 0.3, textureSize: Vector2(152, 142));
  final spriteSize = Vector2(152, 142);
}
