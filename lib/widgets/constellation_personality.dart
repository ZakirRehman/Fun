import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';

class CharacterConstellation extends StatelessWidget {
  final String centerImage;
  final List<String> traits;

  const CharacterConstellation({
    super.key,
    required this.centerImage,
    required this.traits,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final radius = isMobile ? (screenWidth / 3) : 250.0;
    final imageHeight = isMobile ? 250.0 : 400.0;

    return Container(
      height: isMobile ? 400 : 600,
      width: isMobile ? screenWidth : 800,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center Image
          Image.asset(centerImage, height: imageHeight)
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(begin: -10, end: 10, duration: 3.seconds),

          // Trait Constellation
          ...List.generate(traits.length, (index) {
            final angle = (index * (2 * pi / traits.length));
            final x = cos(angle) * radius;
            final y = sin(angle) * radius;

            return Transform.translate(
              offset: Offset(x, y),
              child: _TraitBubble(text: traits[index], delay: (index * 200).ms),
            );
          }),

          // Connecting Lines
          CustomPaint(
            size: Size(radius * 2.5, radius * 2.5),
            painter: ConstellationLinesPainter(traits.length, radius),
          ),
        ],
      ),
    );
  }

}

class _TraitBubble extends StatefulWidget {
  final String text;
  final Duration delay;

  const _TraitBubble({required this.text, required this.delay});

  @override
  State<_TraitBubble> createState() => _TraitBubbleState();
}

class _TraitBubbleState extends State<_TraitBubble> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: _isHovered ? Colors.white : AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ).animate().fadeIn(delay: widget.delay).scale(delay: widget.delay, curve: Curves.easeOutBack),
    );
  }
}

class ConstellationLinesPainter extends CustomPainter {
  final int count;
  final double radius;
  ConstellationLinesPainter(this.count, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.2)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < count; i++) {
      final angle = (i * (2 * pi / count));
      final dest = Offset(
        center.dx + cos(angle) * radius,
        center.dy + sin(angle) * radius,
      );
      
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..quadraticBezierTo(
          (center.dx + dest.dx) / 2 + 30,
          (center.dy + dest.dy) / 2 - 30,
          dest.dx,
          dest.dy,
        );
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

