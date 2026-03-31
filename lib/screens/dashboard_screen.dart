import 'package:flutter/material.dart';
import '../models/app_role.dart';
import '../services/robot_api.dart';
import '../widgets/aide_shell.dart';
import '../widgets/robot_live_feed.dart';
import 'ai_chat_screen.dart';
import 'localization_screen.dart';
import 'manual_drive_screen.dart';
import 'person_follow_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.api,
    required this.role,
    required this.displayName,
    this.profileKey = '',
    this.isDemoMode = false,
  });

  final RobotApi api;
  final AppRole role;
  final String displayName;
  final String profileKey;
  final bool isDemoMode;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _targetController =
      TextEditingController(text: '21');

  void _open(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _applyTarget() {
    if (widget.isDemoMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Demo mode is active. Target update is disabled.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Target set to ${_targetController.text.trim()}'),
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return AidePanel(
      radius: 22,
      color: Colors.white.withOpacity(0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _navCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26),
      child: AidePanel(
        radius: 26,
        color: const Color(0xFF091337).withOpacity(0.82),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFEF6A3B).withOpacity(0.14),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFEF6A3B),
                size: 28,
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Open screen preview',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AideShell(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 68,
                  height: 68,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: Image.asset('assets/images/robot_hero.png'),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.displayName.isEmpty
                            ? 'Andrew Smith'
                            : widget.displayName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.role.label,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.isDemoMode)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF6A3B).withOpacity(0.18),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: const Color(0xFFEF6A3B).withOpacity(0.32),
                      ),
                    ),
                    child: const Text(
                      'Demo',
                      style: TextStyle(
                        color: Color(0xFFF18B63),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            AidePanel(
              radius: 26,
              color: Colors.black.withOpacity(0.45),
              child: RobotLiveFeed(
                baseUrl: widget.api.baseUrl,
                demoMode: widget.isDemoMode,
              ),
            ),
            const SizedBox(height: 18),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.55,
              children: [
                _statCard('Mode', 'Preview'),
                _statCard('Target', '21'),
                _statCard('Speed', '0.45 m/s'),
                _statCard('Heading', '274°'),
              ],
            ),
            const SizedBox(height: 18),
            AidePanel(
              radius: 26,
              color: Colors.white.withOpacity(0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Target Number',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  AideTextField(
                    controller: _targetController,
                    label: 'Target ID',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _applyTarget,
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Screens',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: 0.9,
              children: [
                if (widget.role == AppRole.admin)
                  _navCard(
                    'Profile',
                    Icons.person_outline_rounded,
                    () => _open(
                      ProfileScreen(
                        api: widget.api,
                        role: widget.role,
                        displayName: widget.displayName,
                        profileKey: widget.profileKey,
                        isDemoMode: widget.isDemoMode,
                      ),
                    ),
                  ),
                _navCard(
                  'Chat AI',
                  Icons.chat_bubble_outline_rounded,
                  () => _open(
                    AiChatScreen(
                      api: widget.api,
                      role: widget.role,
                      displayName: widget.displayName,
                      isDemoMode: widget.isDemoMode,
                    ),
                  ),
                ),
                _navCard(
                  'Manual Drive',
                  Icons.gamepad_rounded,
                  () => _open(
                    ManualDriveScreen(api: widget.api),
                  ),
                ),
                _navCard(
                  'Person Follow',
                  Icons.directions_walk_rounded,
                  () => _open(
                    PersonFollowScreen(api: widget.api),
                  ),
                ),
                if (widget.role == AppRole.admin)
                  _navCard(
                    'Localization',
                    Icons.explore_outlined,
                    () => _open(
                      LocalizationScreen(api: widget.api),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}