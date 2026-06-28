import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme.dart';
import 'pages/home_page.dart';
import 'pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FaryalExeApp());
}


class FaryalExeApp extends StatelessWidget {
  const FaryalExeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FARYAL.EXE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashPage(),
    );
  }
}
