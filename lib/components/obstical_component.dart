import 'dart:math';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_dgs_assigment/constants/globals.dart';
import 'package:flame_dgs_assigment/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class Item extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  static const double itemSpeed = 300;

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(-1, 0) * itemSpeed * dt;

    if (position.x + size.x / 2 < 0) {
      removeFromParent();
    }
  }
}
