import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/home/home_state_provider.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userNotifierProvider);
    final homeState = ref.watch(homeStateProvider);
    final homeStateNotifier = ref.read(homeStateProvider.notifier);

    return FutureBuilder(
      future: homeStateNotifier.loadFlowList(uid: userState.user?.uid),
      builder: (context, snapshot) {
        final flowList = homeState.flowList;

        if (flowList == null || flowList.isEmpty) {
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
                    title: Text(
                      flowList[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        "focus : ${flowList[index].focusTime} rest : ${flowList[index].restTime}"),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/flow_register");
              },
              child: const Text('flow 생성'),
            ),
          ],
        );
      },
    );
  }
}
