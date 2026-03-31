import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RobotLiveFeed extends StatelessWidget {
  const RobotLiveFeed({
    super.key,
    required this.baseUrl,
    this.height = 220,
    this.demoMode = false,
  });

  final String baseUrl;
  final double height;
  final bool demoMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF090B13),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/robot_hero.png', fit: BoxFit.contain),
          Container(color: Colors.black.withOpacity(0.55)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.videocam_rounded, size: 38, color: AideColors.primary),
                const SizedBox(height: 10),
                Text(
                  demoMode ? 'Demo camera preview' : 'Camera preview placeholder',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    demoMode ? 'Skip mode is active. The live feed will be wired in the next batch.' : baseUrl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AideColors.textMuted, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
