import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame_dgs_assigment/Particles/particle_components.dart';
import 'package:flutter/material.dart';

class MyParticleSystem extends ParticleSystemComponent {
  ParticleSystemComponent circleParticle(
      Vector2 from, Vector2 to, Paint color) {
    ParticleSystemComponent particleSystemComponent = ParticleSystemComponent(
        particle: MovingParticle(
            from: from.clone(),
            to: from.clone() + to,
            child: MyCircleParticleComponet(paint: color)));

    return particleSystemComponent;
  }
}
