import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/flow/flow_repository.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';
import 'package:noti_flutter/models/flow_model.dart';

final flowListProvider =
    FutureProvider.autoDispose<List<FlowModel>>((ref) async {
  final user = ref.watch(userNotifierProvider).user;
  final flowRepository = ref.read(flowRepositoryProvider);
  return await flowRepository.getFlowList(uid: user?.uid ?? "");
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchedFlowList = ref.watch(flowListProvider);

    return fetchedFlowList.when(
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
                      onPressed: () {},
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
