import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';

class TiltHobbyCard extends StatefulWidget {
  final String title;
  final String imagePath;

  const TiltHobbyCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  State<TiltHobbyCard> createState() => _TiltHobbyCardState();
}

class _TiltHobbyCardState extends State<TiltHobbyCard> {
  Offset _mousePos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) {
        final box = context.findRenderObject() as RenderBox;
        final localPos = box.globalToLocal(e.position);
        setState(() {
          _mousePos = Offset(
            (localPos.dx / box.size.width) - 0.5,
            (localPos.dy / box.size.height) - 0.5,
          );
        });
      },
      onExit: (_) => setState(() => _mousePos = Offset.zero),
      child: AnimatedContainer(
        duration: 200.ms,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_mousePos.dy * -0.2)
          ..rotateY(_mousePos.dx * 0.2),
        child: Container(
          width: 240,
          height: 320,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 18),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
