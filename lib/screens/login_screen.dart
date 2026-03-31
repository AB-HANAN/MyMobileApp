import 'package:flutter/material.dart';
import '../models/app_role.dart';
import '../theme/app_theme.dart';
import '../widgets/aide_shell.dart';
import 'connect_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.role});
  final AppRole role;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

  void _continue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConnectScreen(
          role: widget.role,
          username: _usernameController.text.trim(),
          profileKey: _keyController.text.trim(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AideShell(
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(height: 180, child: Image.asset('assets/images/robot_hero.png')),
            const SizedBox(height: 14),
            const Text('Welcome To AIDE', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            const Spacer(),
            AidePanel(
              radius: 28,
              color: AideColors.panel.withOpacity(0.92),
              child: Column(
                children: [
                  const AideSectionTitle('Login'),
                  const SizedBox(height: 16),
                  AideTextField(controller: _usernameController, label: 'Username'),
                  const SizedBox(height: 14),
                  AideTextField(controller: _keyController, label: 'Key', obscureText: true),
                  const SizedBox(height: 18),
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _continue, child: const Text('Login'))),
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
