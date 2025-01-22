import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/my_page/my_page_provider.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPageNotifier = ref.watch(myPageNotifierProvider.notifier);

    ref.listen(myPageNotifierProvider, (prev, next) {
      if (next.user == null) {
        context.go('/log_in');
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("User"),
        ElevatedButton(
            onPressed: () {
              myPageNotifier.logout();
            },
            child: const Text("logout")),
      ],
    );
  }
}
