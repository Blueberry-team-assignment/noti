import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/common/utils/time_formatter.dart';
import 'package:noti_flutter/features/flow/presentation/my_page/flow_history_provider.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStateNotifier = ref.watch(userNotifierProvider.notifier);
    final flowHistoriesState = ref.watch(flowHistoryProvider);

    ref.listen(userNotifierProvider, (prev, next) {
      if (next.user == null) {
        context.go("/log_in");
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "최근 완료한 플로우 기록",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 4,
        ),
        flowHistoriesState.when(
          data: (flowHistories) {
            if (flowHistories.isEmpty) {
              return const Expanded(
                  child: Center(child: Text("아직 완료한 플로우 기록이 없어요")));
            }

            return Expanded(
              child: ListView.builder(
                itemCount: flowHistories.length,
                itemBuilder: (context, index) {
                  final flowHistory = flowHistories[index];
                  final formattedTime =
                      TimeFormatter.formatSecondsToString(flowHistory.flowTime);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              textAlign: TextAlign.left,
                              formattedTime["hours"] != null
                                  ? "${formattedTime["hours"]}시간 ${formattedTime["minutesWithoutPadLeft"]}분"
                                  : "${formattedTime["minutesWithoutPadLeft"]}분",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  flowHistory.flowName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  flowHistory.date
                                      .toIso8601String()
                                      .split("T")[0],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  "${flowHistory.round}회차",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Center(
                              child: Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
          error: (error, stackTrace) => Expanded(
            child: Center(
              child: Text('플로우 기록을 불러오지 못했어요 : $error'),
            ),
          ),
          loading: () => const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        Center(
          child: TextButton(
              onPressed: () async {
                try {
                  await userStateNotifier.logout();
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("로그아웃에 실패했습니다 ${e.toString()}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text(
                "로그아웃",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 14),
              )),
        ),
      ],
    );
  }
}
