import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/flow/presentation/flow_screen/flow_screen_provider.dart';

class FlowScreen extends ConsumerStatefulWidget {
  const FlowScreen({super.key});

  @override
  ConsumerState<FlowScreen> createState() => _FlowScreenState();
}

class _FlowScreenState extends ConsumerState<FlowScreen> {
  int _seconds = 0;
  bool _isRunning = false;
  late Timer _timer;

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer.cancel();
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
    });
  }

  void _finishTimer() {
    _stopTimer();
    setState(() {
      _seconds = 30 * 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(flowScreenProvider).flow;

    final int minutes = (flowState!.focusTime.inSeconds - _seconds) ~/ 60;
    final int seconds = (flowState.focusTime.inSeconds - _seconds) % 60;
    final remainingTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(remainingTime, style: const TextStyle(fontSize: 72)),
            Text('$_seconds', style: const TextStyle(fontSize: 16)),
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : _startTimer,
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: _isRunning ? _stopTimer : null,
                  child: const Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: _finishTimer,
                  child: const Text('finish'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
