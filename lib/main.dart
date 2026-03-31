import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/opening_screen.dart';

void main() {
  runApp(const AideApp());
}

class AideApp extends StatelessWidget {
  const AideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIDE',
      debugShowCheckedModeBanner: false,
      theme: AideTheme.dark(),
      home: const OpeningScreen(),
    );
  }
}
