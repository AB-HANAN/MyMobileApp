import 'package:flutter/material.dart';
import '../models/app_role.dart';
import '../theme/app_theme.dart';
import '../widgets/aide_shell.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class RoleWelcomeScreen extends StatelessWidget {
  const RoleWelcomeScreen({super.key, required this.role});
  final AppRole role;

  @override
  Widget build(BuildContext context) {
    return AideShell(
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(height: 230, child: Image.asset('assets/images/robot_hero.png')),
            const SizedBox(height: 16),
            const Text('Welcome To AIDE', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            AideChip(label: role.label, color: role == AppRole.admin ? AideColors.primary : AideColors.teal),
            const Spacer(),
            AidePanel(
              radius: 28,
              color: AideColors.panel.withOpacity(0.92),
              child: Column(
                children: [
                  const Text('Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen(role: role))),
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen(role: role))),
                      child: const Text('Sign Up'),
                    ),
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
