import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/glass_card.dart';

class ReviewCard extends StatelessWidget {
  final String text;
  final String rating;

  const ReviewCard({
    super.key,
    required this.text,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: GlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
            ),
            const SizedBox(height: 16),
            Text(
              "\"$text\"",
              style: const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            const Text(
              "- Verified Friend",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
