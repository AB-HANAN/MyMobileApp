import 'package:flutter/material.dart';

class HoldButton extends StatelessWidget {
  const HoldButton({
    super.key,
    required this.label,
    required this.onDown,
    required this.onUp,
    this.size = 86,
    this.icon,
  });

  final String label;
  final VoidCallback onDown;
  final VoidCallback onUp;
  final double size;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onDown(),
      onTapUp: (_) => onUp(),
      onTapCancel: onUp,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFF1E2630),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white12,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: 24),
            if (icon != null) const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}