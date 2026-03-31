import 'package:flutter/material.dart';
import '../models/app_role.dart';
import '../services/robot_api.dart';
import '../theme/app_theme.dart';
import '../widgets/aide_shell.dart';
import 'dashboard_screen.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({
    super.key,
    required this.role,
    this.username = '',
    this.profileKey = '',
  });

  final AppRole role;
  final String username;
  final String profileKey;

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final TextEditingController _controller = TextEditingController(text: 'http://192.168.1.8:5000');
  String _status = '';
  bool _busy = false;

  Future<void> _connect({required bool skipCheck}) async {
    final url = _controller.text.trim();
    final api = RobotApi(url);

    if (skipCheck) {
      _goToDashboard(api: api, isDemoMode: true);
      return;
    }

    setState(() {
      _busy = true;
      _status = 'Checking connection...';
    });

    final ok = await api.ping();
    if (!mounted) return;

    if (!ok) {
      setState(() {
        _busy = false;
        _status = 'Cannot reach Jetson. You can still use Skip for now.';
      });
      return;
    }

    try {
      await api.setAutoMode(false);
    } catch (_) {}

    if (!mounted) return;
    _goToDashboard(api: api, isDemoMode: false);
  }

  void _goToDashboard({required RobotApi api, required bool isDemoMode}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardScreen(
          api: api,
          role: widget.role,
          displayName: widget.username.isEmpty ? 'Andrew Smith' : widget.username,
          profileKey: widget.profileKey,
          isDemoMode: isDemoMode,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
            const SizedBox(height: 16),
            const Text('Connect To AIDE', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            const Spacer(),
            AidePanel(
              radius: 28,
              color: AideColors.panel.withOpacity(0.92),
              child: Column(
                children: [
                  AideTextField(controller: _controller, label: 'Jetson Base URL', hintText: 'http://192.168.1.8:5000'),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _busy ? null : () => _connect(skipCheck: false),
                      child: Text(_busy ? 'Connecting...' : 'Connect'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _busy ? null : () => _connect(skipCheck: true),
                      child: const Text('Skip for now'),
                    ),
                  ),
                  if (_status.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(_status, textAlign: TextAlign.center, style: const TextStyle(color: AideColors.textMuted)),
                  ],
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
