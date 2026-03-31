import 'package:flutter/material.dart';
import '../models/app_role.dart';
import '../services/robot_api.dart';
import '../theme/app_theme.dart';
import '../widgets/aide_shell.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({
    super.key,
    required this.api,
    required this.role,
    required this.displayName,
    this.isDemoMode = false,
  });

  final RobotApi api;
  final AppRole role;
  final String displayName;
  final bool isDemoMode;

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'user': false, 'text': 'Hello, ${'Andrew Smith'}. How may I assist?'}
  ];

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'user': true, 'text': text});
      _messages.add({
        'user': false,
        'text': widget.isDemoMode
            ? 'This is the visual chat preview. Real backend chat wiring comes in part 2.'
            : 'Chat backend integration will be finalized in part 2.'
      });
    });
    _controller.clear();
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
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
        child: Column(
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
                const Expanded(child: Text('Chat AI', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900))),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _messages.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final m = _messages[index];
                  final isUser = m['user'] == true;
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 290),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isUser ? AideColors.primary : Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(isUser ? 0.0 : 0.06)),
                      ),
                      child: Text(m['text'].toString()),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            AidePanel(
              radius: 22,
              color: AideColors.panel.withOpacity(0.94),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Ask anything...',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: _send,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AideColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.arrow_upward_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
