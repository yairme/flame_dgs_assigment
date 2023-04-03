import 'package:flame/components.dart';
import 'package:flame_dgs_assigment/constants/globals.dart';
import 'package:flame_dgs_assigment/flappy_bird_game.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<FlappyBirdGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Global.backgroundSprite);
    size = gameRef.size;
  }
}
