import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';
import 'package:noti_flutter/features/flow/presentation/my_page/my_page_provider.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userNotifierProvider);
    final userNotifier = ref.watch(userNotifierProvider.notifier);
    final myPageState = ref.watch(myPageNotifierProvider(userState));
    final myPageNotifier = ref.read(myPageNotifierProvider(userState).notifier);

    ref.listen(myPageNotifierProvider(userState), (prev, next) {
      if (next.user == null) {
        context.go('/log_in');
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("User"),
        Text(myPageState.user.toString()),
        ElevatedButton(
            onPressed: () async {
              try {
                await myPageNotifier.logout(
                  isAuthUser: userState.user!.isAuthUser,
                );
                userNotifier
                    .resetUserState(); // 이걸 하지 않으면 login state에 user가 남아 있음
              } catch (e) {}
            },
            child: const Text("logout")),
      ],
    );
  }
}
