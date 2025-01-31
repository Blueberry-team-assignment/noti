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
  int elapsedSeconds = 0;
  bool isRunning = false;
  bool isFocusTime = true;
  late Timer _timer;

  void startTimer() {
    setState(() {
      isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final flowState = ref.read(flowScreenProvider).flow;
        if (flowState != null &&
            elapsedSeconds >= flowState.focusTime.inSeconds) {
          isFocusTime = false;
          stopTimer();
          return;
        }

        elapsedSeconds++;
      });
    });
  }

  void stopTimer() {
    setState(() {
      isRunning = false;
    });
    _timer.cancel();
  }

  void resetTimer() {
    setState(() {
      elapsedSeconds = 0;
    });
  }

  void finishTimer() {
    setState(() {
      elapsedSeconds = 30 * 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(flowScreenProvider).flow;

    final int focusMinutes =
        (flowState!.focusTime.inSeconds - elapsedSeconds) ~/ 60;
    final int focusSeconds = focusMinutes > 0
        ? (flowState.focusTime.inSeconds - elapsedSeconds) % 60
        : 0;
    final remainingTime =
        '${focusMinutes.toString().padLeft(2, '0')}:${focusSeconds.toString().padLeft(2, '0')}';

    return Scaffold(
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isFocusTime ? "몰입" : "휴식"),
            Text(remainingTime, style: const TextStyle(fontSize: 72)),
            Text('$elapsedSeconds', style: const TextStyle(fontSize: 16)),
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isRunning ? null : startTimer,
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: isRunning ? stopTimer : null,
                  child: const Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: finishTimer,
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
