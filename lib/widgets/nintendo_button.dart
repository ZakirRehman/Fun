import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';

class NintendoButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;
  final bool isSecondary;

  const NintendoButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color,
    this.isSecondary = false,
  });

  @override
  State<NintendoButton> createState() => _NintendoButtonState();
}

class _NintendoButtonState extends State<NintendoButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.color ?? AppColors.primary;
    final backgroundColor = widget.isSecondary ? Colors.white : primaryColor;
    final textColor = widget.isSecondary ? primaryColor : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: 100.ms,
          curve: Curves.easeInOut,
          transform: _isPressed 
              ? Matrix4.translationValues(0, 4, 0) 
              : (_isHovered ? Matrix4.translationValues(0, -2, 0) : Matrix4.identity()),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isSecondary ? AppColors.border : primaryColor.withOpacity(0.8),
              width: 3,
            ),
            boxShadow: _isPressed ? [] : [
              BoxShadow(
                color: primaryColor.withOpacity(0.3),
                blurRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: textColor, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
