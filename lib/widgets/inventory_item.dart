import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';
import '../widgets/glass_card.dart';

class InventoryItem extends StatelessWidget {
  final String name;
  final String tooltip;
  final IconData icon;

  const InventoryItem({
    super.key,
    required this.name,
    required this.tooltip,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      preferBelow: false,
      textStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, color: Colors.white),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GlassCard(
        padding: EdgeInsets.zero,
        borderRadius: 12,
        child: Container(
          width: 80,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primary, size: 32),
              const SizedBox(height: 4),
              Text(
                name,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 3.seconds, color: Colors.white24),
    );
  }
}
