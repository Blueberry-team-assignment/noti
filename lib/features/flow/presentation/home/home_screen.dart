import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/flow/presentation/flow_screen/flow_timer_provider.dart';
import 'package:noti_flutter/features/flow/presentation/home/flow_list_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowListState = ref.watch(flowListProvider);
    final flowTimerNotifier = ref.read(flowTimerProvider.notifier);

    return flowListState.when(
      data: (flowList) {
        if (flowList.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("아직 등록된 플로우가 없어요"),
              ElevatedButton(
                onPressed: () {
                  context.push("/flow_register");
                },
                child: const Text('플로우 만들러 가기'),
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
                        flowTimerNotifier.setFlowInfo(flowList[index]);
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
                        "집중: ${flowList[index].focusTime.inMinutes}분  휴식: ${flowList[index].restTime.inMinutes}분"),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.push("/flow_register");
                },
                child: const Text('새 플로우 등록하기'),
              ),
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
