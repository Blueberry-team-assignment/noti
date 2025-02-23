import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/flow/presentation/flow_screen/flow_timer_screen.dart';
import 'package:noti_flutter/features/flow/presentation/home/flow_list_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowListState = ref.watch(flowListProvider);

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
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      trailing: TextButton(
                        onPressed: () {
                          // 1. 플로우 타이머 초기화
                          ref.read(flowTimerProvider.notifier).state =
                              flowList[index];
                          // 2. 플로우 타이머 스크린으로 이동
                          context.go('/flow');
                        },
                        child: Text(
                          "시작하기",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      title: Text(
                        flowList[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                          "몰입: ${flowList[index].focusTime.inMinutes}분  휴식: ${flowList[index].restTime.inMinutes}분"),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary),
              onPressed: () {
                context.push("/flow_register");
              },
              child: Text(
                '새 플로우 등록하기',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
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
