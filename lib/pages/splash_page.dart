import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _walkController;
  late AnimationController _textController;
  bool _morphed = false;
  double _characterPos = -0.5; // Start off-screen left

  @override
  void initState() {
    super.initState();
    _walkController = AnimationController(vsync: this, duration: 3.seconds);
    _textController = AnimationController(vsync: this, duration: 1.seconds);
    
    _startSequence();
  }

  void _startSequence() async {
    // 1. Walk to center
    setState(() => _characterPos = 0.0);
    await Future.delayed(2.seconds);
    
    // 2. Fade in "I am Fr."
    _textController.forward();
    await Future.delayed(1.seconds);
    
    // 3. Morph to "I'm fr."
    setState(() => _morphed = true);
    await Future.delayed(1500.ms);

    // 4. Transform to Home
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: 1.seconds,
        ),
      );
    }
  }

  @override
  void dispose() {
    _walkController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0F7FF), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Walking Character
            AnimatedAlign(
              duration: 2.seconds,
              curve: Curves.easeOutCubic,
              alignment: Alignment(_characterPos, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('static/images/f_1.png', height: 250)
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: -5, end: 5, duration: 500.ms),
                  const SizedBox(height: 48),
                  
                  // Morphing Text
                  FadeTransition(
                    opacity: _textController,
                    child: AnimatedDefaultTextStyle(
                      duration: 400.ms,
                      curve: Curves.elasticOut,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: _morphed ? 48 : 40,
                        fontWeight: _morphed ? FontWeight.w900 : FontWeight.w600,
                        color: AppColors.text,
                      ),
                      child: Text(_morphed ? "I'm fr." : "I am Fr."),
                    ),
                  ),
                ],
              ),
            ),

            // Particles (Simplified)
            ...List.generate(5, (i) => _buildParticle(i)),
          ],
        ),
      ),
    );
  }

  Widget _buildParticle(int i) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height / 2 - 100,
      left: MediaQuery.of(context).size.width / 2 - 50 + (i * 20),
      child: const Icon(Icons.auto_awesome, color: AppColors.primary, size: 10)
          .animate(onPlay: (c) => c.repeat())
          .moveY(end: -50, duration: 1.seconds)
          .fadeOut(),
    );
  }
}
