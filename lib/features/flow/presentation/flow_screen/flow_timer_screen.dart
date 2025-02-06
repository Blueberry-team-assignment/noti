import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/flow/presentation/flow_screen/flow_timer_provider.dart';

class FlowTimerScreen extends ConsumerStatefulWidget {
  const FlowTimerScreen({super.key});

  @override
  ConsumerState<FlowTimerScreen> createState() => _FlowTimerScreenState();
}

class _FlowTimerScreenState extends ConsumerState<FlowTimerScreen> {
  int elapsedSeconds = 0;
  bool isRunning = false;
  bool isFocusTime = true;
  late Timer _timer;

  void startTimer() {
    // 타이머의 제한 시간 설정
    final flowTimerState = ref.watch(flowTimerProvider).flow;
    if (flowTimerState == null) return;

    final timeLimit = isFocusTime
        ? flowTimerState.focusTime.inSeconds
        : flowTimerState.restTime.inSeconds;
    setState(() {
      isRunning = true;
    });

    // 타이머 초기화
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (elapsedSeconds >= timeLimit) {
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

  // 타이머 종료 (제한 시간 모두 소모시키기)
  void finishTimer() {
    isFocusTime = !isFocusTime;
    stopTimer();
    resetTimer();
  }

  static Map<String, String> formatSecondsToMMSS(int? time) {
    if (time == null) return {};

    return {
      "minutes": (time ~/ 60).toString().padLeft(2, "0"),
      "seconds": (time % 60).toString().padLeft(2, "0"),
      "minutesWithoutPadLeft": (time ~/ 60).toString(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final flowTimerState = ref.watch(flowTimerProvider).flow;

    // string으로 변환된 집중 시간과 휴식 시간(MM)
    final focusTime = formatSecondsToMMSS(
        flowTimerState?.focusTime.inSeconds)["minutesWithoutPadLeft"];
    final restTime = formatSecondsToMMSS(
        flowTimerState?.restTime.inSeconds)["minutesWithoutPadLeft"];

    // 타이머의 제한 시간
    final timeLimit = isFocusTime
        ? flowTimerState?.focusTime.inSeconds
        : flowTimerState?.restTime.inSeconds;
    // 화면에 표시될 타이머의 남은 시간 (MM:SS)
    final remainingTime = formatSecondsToMMSS(
        timeLimit != null ? timeLimit - elapsedSeconds : null);

    return Scaffold(
      body: Center(
        child: Column(
          spacing: 0,
          children: [
            Text(
              "${flowTimerState?.name ?? ""} ${isFocusTime ? "집중" : "휴식"} 시간",
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "${remainingTime["minutes"]}:${remainingTime["seconds"]}",
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            Text(
              '${isFocusTime ? focusTime : restTime}분 중 남은 시간',
              style: TextStyle(
                  fontSize: 12, color: Theme.of(context).disabledColor),
            ),
            const SizedBox(
              height: 20,
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
                      Text(isFocusTime ? "1단계" : "2단계"),
                      Text(
                          "${flowTimerState?.name} ${isFocusTime ? "집중하기" : "휴식하기"} (${isFocusTime ? focusTime : restTime}분)")
                    ],
                  ),
                  LinearProgressIndicator(
                    value: elapsedSeconds / (timeLimit ?? 1),
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
                      Text(isFocusTime ? "2단계" : "1단계"),
                      Text(
                          "${flowTimerState?.name} ${isFocusTime ? "휴식하기" : "집중하기"} (${isFocusTime ? restTime : focusTime}분)")
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: isRunning ? stopTimer : startTimer,
                    child: Text(
                      isRunning ? '일시정지' : "시작하기",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onError,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: finishTimer,
                    child: Text(
                      '종료하기',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
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
