import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/flow/presentation/flow_screen/flow_timer_provider.dart';
import 'package:noti_flutter/features/flow/presentation/home/flow_list_provider.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowListState = ref.watch(flowListProvider);
    final flowScreenNotifier = ref.read(flowTimerProvider.notifier);

    return flowListState.when(
      data: (flowList) {
        if (flowList.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("아직 등록된 플로우가 없어요"),
              ElevatedButton(
                onPressed: () {
                  context.pushReplacement("/flow_register");
                },
                child: const Text('flow 생성'),
              ),
            ],
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: flowList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: ElevatedButton(
                      onPressed: () {
                        flowScreenNotifier.setFlowInfo(flowList[index]);
                        context.go('/flow');
                      },
                      child: const Text("시작하기"),
                    ),
                    title: Text(
                      flowList[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        "몰입: ${flowList[index].focusTime.inMinutes}분  휴식: ${flowList[index].restTime.inMinutes}분"),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.pushReplacement("/flow_register");
              },
              child: const Text('flow 생성'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stackTrace) => Center(
        child: Text("플로우 목록을 불러오지 못했습니다: $err"),
      ),
    );
  }
}
