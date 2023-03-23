import 'package:flame/components.dart';
import 'package:flame_dgs_assigment/constants/globals.dart';
import 'package:flame_dgs_assigment/games/flappy_bird_game.dart';

class PlayerComponent extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  final double _spriteHeight = 200;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Global.playerSprite);
    position = gameRef.size / 2;
    height = _spriteHeight;
    width = _spriteHeight * 1.45;
    anchor = Anchor.center;
  }
}
