import 'dart:async';
import 'package:flutter/material.dart';
import '../services/robot_api.dart';
import '../widgets/robot_live_feed.dart';

class PersonFollowScreen extends StatefulWidget {
  const PersonFollowScreen({super.key, required this.api});
  final RobotApi api;

  @override
  State<PersonFollowScreen> createState() => _PersonFollowScreenState();
}

class _PersonFollowScreenState extends State<PersonFollowScreen> {
  Timer? _timer;
  Telemetry? _t;
  String _msg = '';

  @override
  void initState() {
    super.initState();
    _refresh();
    _timer = Timer.periodic(const Duration(milliseconds: 700), (_) => _refresh());
  }

  Future<void> _refresh() async {
    final t = await widget.api.getTelemetry();
    if (!mounted) return;
    setState(() => _t = t);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = _t;

    return Scaffold(
      appBar: AppBar(title: const Text('Person Following')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RobotLiveFeed(baseUrl: widget.api.baseUrl, height: 220),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await widget.api.setAutoMode(true);
                    await _refresh();
                    setState(() => _msg = 'AUTO follow mode requested');
                  },
                  child: const Text('Start Follow'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    await widget.api.setAutoMode(false);
                    await _refresh();
                    setState(() => _msg = 'Switched back to MANUAL');
                  },
                  child: const Text('Stop Follow'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Target: ${t?.target ?? '-'}'),
          Text('Lock: ${t?.locked == true ? 'YES' : 'NO'}'),
          Text('Follow state: ${t?.followState ?? '-'}'),
          Text('Distance: ${t?.distM.toStringAsFixed(2) ?? '0.00'} m'),
          Text('FPS: ${t?.fps.toStringAsFixed(1) ?? '0.0'}'),
          Text('Last gesture: ${t?.lastGesture ?? '-'}'),
          Text('Gesture system status: ${t?.gestures == true ? 'ON' : 'OFF'}'),
          Text('Follow enabled flag: ${t?.followEnabled == true ? 'ON' : 'OFF'}'),
          Text('Tilt: ${t?.tiltDeg.toStringAsFixed(0) ?? '0'}°'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTapDown: (_) => widget.api.tiltUpStart(),
                  onTapUp: (_) => widget.api.tiltStop(),
                  onTapCancel: () => widget.api.tiltStop(),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Tilt Up'),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await widget.api.tiltCenter();
                    await _refresh();
                  },
                  child: const Text('Center'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTapDown: (_) => widget.api.tiltDownStart(),
                  onTapUp: (_) => widget.api.tiltStop(),
                  onTapCancel: () => widget.api.tiltStop(),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Tilt Down'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(_msg),
        ],
      ),
    );
  }
}