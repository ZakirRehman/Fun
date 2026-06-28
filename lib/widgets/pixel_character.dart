import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum FaryalPose {
  shy,
  peace,
  back,
  standing,
  phone,
}

class PixelCharacter extends StatelessWidget {
  final FaryalPose pose;
  final double size;

  const PixelCharacter({
    super.key,
    this.pose = FaryalPose.standing,
    this.size = 300,
  });

  String get _assetPath {
    switch (pose) {
      case FaryalPose.shy:
        return 'static/images/f_3.png';
      case FaryalPose.peace:
        return 'static/images/f_2.png';
      case FaryalPose.back:
        return 'static/images/f_5.png';
      case FaryalPose.standing:
        return 'static/images/f_1.png';
      case FaryalPose.phone:
        return 'static/images/f_4.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Image.asset(
        _assetPath,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.none, // Keep it pixelated
        errorBuilder: (context, error, stackTrace) {
          // Fallback if assets aren't there yet
          return Icon(
            Icons.person,
            size: size * 0.8,
            color: Colors.blue.withOpacity(0.3),
          );
        },
      ),
    )
    .animate(onPlay: (controller) => controller.repeat(reverse: true))
    .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOut);
  }
}
