import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/flow/presentation/flow_screen/flow_screen_provider.dart';
import 'package:noti_flutter/utils/time_formatter.dart';

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
        ref.read(flowScreenProvider).flow?.focusTime.inSeconds ?? 30 * 60;
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
          ? flowState?.focusTime.inSeconds ?? 30 * 60
          : flowState?.restTime.inSeconds ?? 5 * 60;
    });
  }

  static Map<String, String> formatSecondsToMMSS(int? time) {
    if (time == null) return {};

    return {
      "minutes": (time ~/ 60).toString().padLeft(2, "0"),
      "seconds": (time % 60).toString().padLeft(2, "0"),
    };
  }

  get remainingTime => formatSecondsToMMSS(timeLimit - elapsedSeconds);

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(flowScreenProvider).flow;
    final focusTime =
        formatSecondsToMMSS(flowState?.focusTime.inSeconds)["minutes"];
    final restTime =
        formatSecondsToMMSS(flowState?.restTime.inSeconds)["minutes"];

    return Scaffold(
      body: Center(
        child: Column(
          spacing: 0,
          children: [
            Text(
              "${flowState?.name ?? ""} ${isFocusTime ? "집중" : "휴식"} 시간",
              style: const TextStyle(fontSize: 24),
            ),
            Text("${remainingTime["minutes"]}:${remainingTime["seconds"]}",
                style: const TextStyle(fontSize: 64)),
            Text(
              '${isFocusTime ? focusTime : restTime}분 중 남은 시간',
              style: TextStyle(
                  fontSize: 12, color: Theme.of(context).disabledColor),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("현재 진행중인 플로우"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("1단계"),
                      Text("${flowState?.name} 집중하기 ($focusTime분)")
                    ],
                  ),
                  const LinearProgressIndicator(
                    value: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "진행률 %",
                        style:
                            TextStyle(color: Theme.of(context).disabledColor),
                      ),
                      Text("$focusTime분 집중 후 $restTime분 휴식")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("2단계"),
                      Text("${flowState?.name} 휴식하기 ($restTime분)")
                    ],
                  ),
                ],
              ),
            ),
            Row(
              spacing: -20,
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
