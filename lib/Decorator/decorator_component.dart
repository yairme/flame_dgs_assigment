import 'package:flame/components.dart';
import 'package:flame_dgs_assigment/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class Decorator extends Component with HasGameRef<FlappyBirdGame> {
  late final Paint _paint;

  Decorator() {
    _paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(
      10,
      10,
      gameRef.size.x - 20,
      gameRef.size.y - 25,
    );
    canvas.drawRect(rect, _paint);
  }
}
