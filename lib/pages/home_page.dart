import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../widgets/modern_navbar.dart';
import '../widgets/tilt_hobby_card.dart';
import '../widgets/constellation_personality.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  Offset _eyeFocus = Offset.zero;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
    _startPopupTimer();
  }

  void _startPopupTimer() {
    Timer.periodic(Duration(seconds: 20 + Random().nextInt(20)), (timer) {
      if (mounted) _showRandomPopup();
    });
  }

  void _showRandomPopup() {
    final messages = [
      "Achievement: Made another friend.",
      "Breaking News: Faryal has started another conversation.",
      "System: Overthinking...",
      "Loading... Social battery found. 100%",
      "Alert: Professional yapper detected.",
    ];
    final message = messages[Random().nextInt(messages.length)];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.sparkles, color: AppColors.primary, size: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.outfit(color: AppColors.text, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: 3.seconds,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onHover: (e) {
          setState(() {
            _eyeFocus = Offset(
              (e.localPosition.dx / MediaQuery.of(context).size.width) - 0.5,
              (e.localPosition.dy / MediaQuery.of(context).size.height) - 0.5,
            );
          });
        },
        child: Stack(
          children: [
            // Background
            Container(color: AppColors.background),
            
            // Content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _buildHeroSection(),
                  _buildSkillsSection(),
                  _buildHobbiesSection(),
                  _buildPersonalitySection(),
                  _buildGallerySection(),
                  _buildFooter(),
                ],
              ),
            ),

            // Navbar
            Align(
              alignment: Alignment.topCenter,
              child: ModernNavbar(
                items: const ["About", "Skills", "Personality", "Hobbies", "Gallery"],
                onItemTap: (index) {
                  // Scrolling logic
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildHeroSection() {
    final isMobile = MediaQuery.of(context).size.width < 800;
    
    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 100, vertical: isMobile ? 100 : 0),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi,\nI'm Faryal.",
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: isMobile ? 40 : 64,
                  ),
                ).animate().slideX(begin: -0.2).fadeIn(duration: 800.ms),

                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                  children: [
                    "Talkative.", "Creative.", "Kind.", "A little weird.", "Professionally overthinking."
                  ].map((s) => _buildChip(s)).toList(),
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 48),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Get to know me", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
                      const SizedBox(width: 6),
                      const Icon(LucideIcons.arrowRight, size: 18, color: AppColors.primary),
                    ],
                  ),
                ).animate().fadeIn(delay: 600.ms),

              ],
            ),
          ),
          if (isMobile) const SizedBox(height: 64),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Floating Character
                  Transform.translate(
                    offset: Offset(_eyeFocus.dx * 20, _eyeFocus.dy * 20),
                    child: Image.asset('static/images/f_2.png', height: isMobile ? 280 : 420)

                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .moveY(begin: -15, end: 15, duration: 4.seconds),
                  ),
                  // Eye tracking overlay
                  Positioned(
                    top: isMobile ? 100 : 150,
                    child: Row(
                      children: [
                        _buildEye(),
                        SizedBox(width: isMobile ? 24 : 40),
                        _buildEye(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEye() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    ).animate().move(
      begin: Offset(_eyeFocus.dx * 2, _eyeFocus.dy * 2),
      end: Offset(_eyeFocus.dx * 4, _eyeFocus.dy * 4),
      duration: 100.ms,
    );
  }


  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.primary)),
    );
  }


  Widget _buildSkillsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      child: Column(
        children: [
          Text("Expertise", style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 100),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _buildModernSkillCard("Mehendi Artist", "f_3.png", "Can turn empty hands into artwork."),
              _buildModernSkillCard("Creative", "f_4.png", "Always making something."),
              _buildModernSkillCard("Communication", "f_5.png", "Can literally become friends with anyone."),
              _buildModernSkillCard("Safe Person", "f_6.png", "People naturally feel comfortable around her."),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernSkillCard(String title, String asset, String desc) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 30, offset: const Offset(0, 15))],
      ),
      child: Column(
        children: [
          Image.asset('static/images/$asset', height: 90),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc, textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: AppColors.text.withOpacity(0.6))),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9));
  }


  Widget _buildHobbiesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        children: [
          Text("Passions", style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 80),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                const TiltHobbyCard(title: "Drawing", imagePath: 'static/images/f_7.png'),
                const SizedBox(width: 40),
                const TiltHobbyCard(title: "Coffee", imagePath: 'static/images/f_8.png'),
                const SizedBox(width: 40),
                const TiltHobbyCard(title: "Photography", imagePath: 'static/images/f_9.png'),
                const SizedBox(width: 40),
                const TiltHobbyCard(title: "Music", imagePath: 'static/images/f_1.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalitySection() {
    return Container(
      height: 800,
      child: Column(
        children: [
          Text("Inside Out", style: Theme.of(context).textTheme.displayMedium),
          const Expanded(
            child: CharacterConstellation(
              centerImage: 'static/images/f_1.png',
              traits: ["Kind", "Talkative", "Sensitive", "Funny", "Creative", "Shy", "Weird"],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallerySection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          Text("Moments", style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 100),
          SizedBox(
            height: isMobile ? 1200 : 600,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: List.generate(9, (index) {
                final random = Random(index);
                double left, top;
                
                if (isMobile) {
                  left = (screenWidth - 200) / 2 + (random.nextDouble() - 0.5) * 50;
                  top = index * 120.0;
                } else {
                  left = 50 + (index * (screenWidth - 300) / 9) + (random.nextDouble() - 0.5) * 100;
                  top = 50 + random.nextDouble() * 300;
                }

                return Positioned(
                  left: left,
                  top: top,
                  child: Transform.rotate(
                    angle: (random.nextDouble() - 0.5) * 0.3,
                    child: _buildGalleryCard(index + 1),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildGalleryCard(int index) {
    return Container(
      width: 160,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15)],
      ),
      padding: const EdgeInsets.all(10),

      child: Column(
        children: [
          Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset('static/images/f_$index.png', fit: BoxFit.cover))),
          const SizedBox(height: 12),
          const Text("Moment #001", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    ).animate().moveY(begin: 100, duration: 1.seconds).fadeIn();
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          Image.asset('static/images/f_1.png', height: 160),
          const SizedBox(height: 32),
          Text("Thanks for visiting.", style: Theme.of(context).textTheme.displaySmall),
          const Text("Now you officially know Fari."),
          const SizedBox(height: 20),
          const Text("Happy Birthday \uD83D\uDDA4", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.primary)),
        ],
      ),
    );
  }

}

