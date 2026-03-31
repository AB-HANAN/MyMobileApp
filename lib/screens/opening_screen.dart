import 'package:flutter/material.dart';
import '../models/app_role.dart';
import '../theme/app_theme.dart';
import '../widgets/aide_shell.dart';
import 'role_welcome_screen.dart';

class OpeningScreen extends StatelessWidget {
  const OpeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AideShell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: Column(
          children: [
            const Spacer(flex: 2),
            SizedBox(
              height: 290,
              child: Image.asset('assets/images/robot_hero.png', fit: BoxFit.contain),
            ),
            const SizedBox(height: 12),
            const Text(
              'Welcome To AIDE',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Autonomous Interactive Delivery Entity',
                textAlign: TextAlign.center,
                style: TextStyle(color: AideColors.textMuted, height: 1.45),
              ),
            ),
            const Spacer(),
            AidePanel(
              radius: 28,
              padding: const EdgeInsets.all(18),
              color: AideColors.panel.withOpacity(0.92),
              child: Column(
                children: [
                  _RoleButton(
                    title: 'Admin',
                    subtitle: 'Full control and system settings',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoleWelcomeScreen(role: AppRole.admin))),
                  ),
                  const SizedBox(height: 12),
                  _RoleButton(
                    title: 'User',
                    subtitle: 'Operator access and assistant chat',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoleWelcomeScreen(role: AppRole.user))),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  const _RoleButton({required this.title, required this.subtitle, required this.onTap});
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.07)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AideColors.primary.withOpacity(0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.arrow_outward_rounded, color: AideColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: AideColors.textMuted, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
