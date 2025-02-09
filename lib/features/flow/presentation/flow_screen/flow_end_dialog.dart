// 플로우 종료하기 버튼 눌렀을 때 표시될 모달 위젯.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/dto/flow_history_dto.dart';
import 'package:noti_flutter/features/flow/presentation/my_page/flow_history_provider.dart';

class FlowEndDialog extends ConsumerWidget {
  final int round;
  final String flowName;
  final int flowTime;

  const FlowEndDialog({
    super.key,
    required this.round,
    required this.flowName,
    required this.flowTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      icon: const Icon(Icons.timer_outlined),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Colors.white,
      content: Text(
        textAlign: TextAlign.center,
        "$flowName 플로우를 $round회 완료했어요",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            // 플로우 기록을 저장 후 종료.
            ref.read(flowHistoryProvider.notifier).createFlowHistory(
                    flowHistoryDto: FlowHistoryDto(
                  date: DateTime.now(),
                  flowName: flowName,
                  round: round,
                  flowTime: flowTime,
                ));
            context.go("/home");
          },
          child: Text(
            "기록 저장 후 종료하기",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {
            context.go('/home');
          },
          child: Text(
            "기록 저장하지 않고 종료하기",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
