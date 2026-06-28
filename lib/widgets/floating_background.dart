import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../core/theme.dart';

class FloatingBackground extends StatelessWidget {
  const FloatingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(20, (index) {
        final random = Random(index);
        final isDino = random.nextBool();
        final isHeart = random.nextBool();
        final icon = isDino 
            ? LucideIcons.loader // Dinosaur placeholder
            : (isHeart ? LucideIcons.heart : LucideIcons.cloud);
        
        final size = 20.0 + random.nextDouble() * 40.0;
        final startX = random.nextDouble() * MediaQuery.of(context).size.width;
        final startY = random.nextDouble() * MediaQuery.of(context).size.height;
        final duration = 15.seconds + (random.nextInt(10)).seconds;

        return Positioned(
          left: startX,
          top: startY,
          child: Opacity(
            opacity: 0.1,
            child: Icon(
              icon,
              size: size,
              color: AppColors.primary,
            ),
          )
          .animate(onPlay: (c) => c.repeat())
          .moveX(end: 100, duration: duration, curve: Curves.easeInOut)
          .moveY(end: -100, duration: duration, curve: Curves.easeInOut)
          .fadeOut(duration: duration, curve: Curves.easeInOut),
        );
      }),
    );
  }
}
