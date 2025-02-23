import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/common/utils/time_formatter.dart';
import 'package:noti_flutter/features/flow/presentation/flow_screen/flow_end_dialog.dart';
import 'package:noti_flutter/models/flow_model.dart';
import 'package:noti_flutter/services/local_notification.dart';

/*  플로우 타이머 실행에 필요한 데이터들을 초기화하기 위한 프로바이더
    HomeScreen의 플로우 목록에서 플로우 시작하기를 탭 했을때, 해당 플로우의 데이터로 초기화됩니다.
    단순히 화면에서 사용자가 선택한 Flow객체를 초기화하는 역할만 필요하기 때문에 StateProvider로 작성했습니다.
 */
final flowTimerProvider = StateProvider<FlowModel?>((ref) {
  return null;
});

class FlowTimerScreen extends ConsumerStatefulWidget {
  const FlowTimerScreen({super.key});

  @override
  ConsumerState<FlowTimerScreen> createState() => _FlowTimerScreenState();
}

class _FlowTimerScreenState extends ConsumerState<FlowTimerScreen> {
  int elapsedSeconds = 0; // 타이머가 시작되고 경과된 시간
  bool isRunning = false; // 타이머가 동작 중인가
  bool isFocusTime = true; // 현재 집중단계(1단계)인가
  int round = 1; // 플로우가 몇 회차인지
  Timer? _timer;

  @override
  void dispose() {
    // 런타입 에러를 방지하기 위해 타이머가 초기화 된 상태일 때만 타이머를 종료하도록 함
    _timer?.cancel();
    super.dispose();
  }

  // [타이머]. 시작하기
  void startTimer() {
    // 1. 타이머의 제한 시간 설정
    final flowTimerState = ref.watch(flowTimerProvider);
    if (flowTimerState == null) return;

    final timeLimit = isFocusTime
        ? flowTimerState.focusTime.inSeconds
        : flowTimerState.restTime.inSeconds;
    setState(() {
      isRunning = true;
    });

    // 2. 타이머 초기화
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (elapsedSeconds >= timeLimit) {
          showNotification();
          goToNextPhase();
        } else {
          elapsedSeconds++;
        }
      });
    });
  }

  // 로컬 알림 발송
  void showNotification() async {
    // 1. 알림 발송에 필요한 os별 설정 초기화.
    NotificationDetails details = const NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      android: AndroidNotificationDetails(
        "1",
        "test",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    // 2. 알림 발송 요청
    await ref.watch(localNotificationProvider).show(
        1,
        isFocusTime ? "집중 시간이 종료되었어요" : "휴식 시간이 종료되었어요",
        isFocusTime ? "좋은 집중 시간이었어요! 잠시 쉬어가세요. 😊" : "이제 다시 집중할 시간이에요! 💪",
        details);
  }

  // [타이머]. 일시정지
  void stopTimer() {
    setState(() {
      isRunning = false;
    });
    _timer!.cancel();
  }

  // [타이머]. 현재 단계를 다시 시작하기.
  void rewindTimer() {
    stopTimer();
    setState(() {
      elapsedSeconds = 0;
    });
  }

  // [타이머]. 다음 단계로 건너뛰기
  void goToNextPhase() {
    // 1. 휴식단계까지 다 끝났으면 회차++
    if (!isFocusTime) {
      round++;
    }

    // 2. 다음 단계 타이머를 위해 설정 초기화
    isFocusTime = !isFocusTime;
    stopTimer();
    rewindTimer();
  }

  // [타이머]. 이전 단계로 돌아가기
  void backToPreviousPhase() {
    setState(() {
      isFocusTime = !isFocusTime;
    });
  }

  // 중첩된 삼항연산자 리팩토링: 상태에 따른 버튼 액션 반환 함수
  VoidCallback? _getButtonAction() {
    if (isRunning) return goToNextPhase;
    if (elapsedSeconds > 0) return rewindTimer;
    if (isFocusTime) return null; // 버튼 비활성화
    return backToPreviousPhase;
  }

  @override
  Widget build(BuildContext context) {
    final flowTimerState = ref.watch(flowTimerProvider);

    // string으로 변환된 집중 시간과 휴식 시간(MM)
    final focusTime = TimeFormatter.formatSecondsToString(
        flowTimerState?.focusTime.inSeconds)["minutesWithoutPadLeft"];
    final restTime = TimeFormatter.formatSecondsToString(
        flowTimerState?.restTime.inSeconds)["minutesWithoutPadLeft"];

    // 현재 단계의 타이머의 제한 시간
    final timeLimit = isFocusTime
        ? flowTimerState?.focusTime.inSeconds
        : flowTimerState?.restTime.inSeconds;
    // 화면에 표시될 타이머의 남은 시간 (MM:SS)
    final remainingTime = TimeFormatter.formatSecondsToString(
        timeLimit != null ? timeLimit - elapsedSeconds : null);

    return Scaffold(
      body: Center(
        child: Column(
          spacing: 0,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  flowTimerState?.name ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  " ${isFocusTime ? "집중" : "휴식"} 시간",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Text(
              "${remainingTime["minutes"]}:${remainingTime["seconds"]}",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(letterSpacing: 1),
            ),
            Text(
              '${isFocusTime ? focusTime : restTime}분 중 남은 시간',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "현재 진행중인 플로우",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "$round",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          Text(
                            " 회차",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    spacing: 8,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isFocusTime ? "1단계" : "2단계",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "${flowTimerState?.name} ${isFocusTime ? "집중하기" : "휴식하기"}(${isFocusTime ? focusTime : restTime}분)",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        color: Theme.of(context).primaryColorDark,
                        value: timeLimit == null
                            ? null
                            : elapsedSeconds / timeLimit,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "진행률 ${timeLimit != null ? (elapsedSeconds / timeLimit * 100).round() : ""}%",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "$focusTime분 집중 후 $restTime분 휴식",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isFocusTime ? "2단계" : "1단계",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "${flowTimerState?.name} ${isFocusTime ? "휴식하기" : "집중하기"}(${isFocusTime ? restTime : focusTime}분)",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: isRunning ? stopTimer : startTimer,
                    child: Text(
                      isRunning ? '일시정지' : "시작하기",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
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
                      backgroundColor: Theme.of(context).focusColor,
                    ),
                    onPressed: _getButtonAction(),
                    child: Text(
                      isRunning
                          ? "건너뛰기"
                          : (elapsedSeconds > 0 ? "다시하기" : "이전 단계로"),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.inverseSurface,
                  ),
                  onPressed: () => _showExitDialog(context, flowTimerState),
                  child: Text(
                    "종료하기",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 종료하기 버튼 눌렀을 때 표시될 모달 호출
  void _showExitDialog(BuildContext context, FlowModel? flowTimerState) {
    if (flowTimerState == null) return;

    showDialog(
      context: context,
      builder: (context) => FlowEndDialog(
        round: round - 1,
        flowName: flowTimerState.name,
        flowTime: (flowTimerState.focusTime.inSeconds +
                flowTimerState.restTime.inSeconds) *
            (round - 1),
      ),
    );
  }
}
