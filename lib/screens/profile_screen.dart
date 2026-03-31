import 'package:flutter/material.dart';
import '../models/app_role.dart';
import '../services/robot_api.dart';
import '../theme/app_theme.dart';
import '../widgets/aide_shell.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.api,
    required this.role,
    required this.displayName,
    required this.profileKey,
    this.isDemoMode = false,
  });

  final RobotApi api;
  final AppRole role;
  final String displayName;
  final String profileKey;
  final bool isDemoMode;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _robotNameController;
  late final TextEditingController _adminNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _adminKeyController;
  late final TextEditingController _userNameController;
  late final TextEditingController _userKeyController;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _robotNameController = TextEditingController(text: 'AIDE');
    _adminNameController = TextEditingController(text: widget.role == AppRole.admin ? widget.displayName : 'Admin Name');
    _phoneController = TextEditingController(text: '+92 300 0000000');
    _adminKeyController = TextEditingController(text: widget.role == AppRole.admin ? widget.profileKey : '');
    _userNameController = TextEditingController(text: widget.role == AppRole.user ? widget.displayName : 'User Name');
    _userKeyController = TextEditingController(text: widget.role == AppRole.user ? widget.profileKey : '');
  }

  @override
  void dispose() {
    _robotNameController.dispose();
    _adminNameController.dispose();
    _phoneController.dispose();
    _adminKeyController.dispose();
    _userNameController.dispose();
    _userKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AideShell(
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Image.asset('assets/images/robot_hero.png'),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('Edit Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                ),
              ],
            ),
            const SizedBox(height: 18),
            AidePanel(
              radius: 24,
              color: AideColors.panel.withOpacity(0.92),
              child: Column(
                children: [
                  AideTextField(controller: _robotNameController, label: 'Robot Name'),
                  const SizedBox(height: 12),
                  AideTextField(controller: _adminNameController, label: 'Admin Name'),
                  const SizedBox(height: 12),
                  AideTextField(controller: _phoneController, label: 'Phone Number', keyboardType: TextInputType.phone),
                  const SizedBox(height: 12),
                  AideTextField(controller: _adminKeyController, label: 'Admin Key', obscureText: true),
                  const SizedBox(height: 12),
                  AideTextField(controller: _userNameController, label: 'User Name'),
                  const SizedBox(height: 12),
                  AideTextField(controller: _userKeyController, label: 'User Key', obscureText: true),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => _message = widget.isDemoMode ? 'Profile preview updated locally for this screen only.' : 'Visual profile is ready. Storage hookup comes in the next batch.');
                      },
                      child: const Text('Update'),
                    ),
                  ),
                  if (_message.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(_message, style: const TextStyle(color: AideColors.textMuted)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
