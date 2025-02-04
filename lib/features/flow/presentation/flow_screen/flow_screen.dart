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
  late int timeLimit;
  int elapsedSeconds = 0;
  bool isRunning = false;
  bool isFocusTime = true;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeLimit =
        ref.read(flowScreenProvider).flow?.focusTime.inSeconds ?? 30 * 1000;
  }

  void startTimer() {
    setState(() {
      isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (elapsedSeconds >= timeLimit) {
          timeLimit = isFocusTime
              ? ref.read(flowScreenProvider).flow?.restTime.inSeconds ??
                  5 * 1000
              : ref.read(flowScreenProvider).flow?.focusTime.inSeconds ??
                  30 * 1000;
          isFocusTime = !isFocusTime;
          stopTimer();
          resetTimer();
          // 알림 발송
          // 한번 더 하겠습니까 다이얼로그 표시
        } else {
          elapsedSeconds++;
        }
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
    final flowState = ref.read(flowScreenProvider).flow;
    setState(() {
      elapsedSeconds = isFocusTime
          ? flowState?.focusTime.inSeconds ?? 30 * 1000
          : flowState?.restTime.inSeconds ?? 5 * 1000;
    });
  }

  get remainingTime =>
      "${((timeLimit - elapsedSeconds) ~/ 60).toString().padLeft(2, "0")}:${((timeLimit - elapsedSeconds) % 60).toString().padLeft(2, "0")}";

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(flowScreenProvider).flow;

    return Scaffold(
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${isFocusTime ? "몰입" : "휴식"} 시간입니다."),
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
            if (flowState != null)
              ListView(
                children: [
                  Text(flowState.name),
                  Text("몰입: ${flowState.focusTime}분"),
                  Text("휴식: ${flowState.restTime}분"),
                ],
              )
          ],
        ),
      ),
    );
  }
}
