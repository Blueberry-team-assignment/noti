import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/log_in/domain/check_user_service.dart';
import 'package:noti_flutter/features/log_in/domain/log_in_usecase.dart';
import 'package:noti_flutter/features/log_in/domain/start_guest_user_usecase.dart';
import 'package:noti_flutter/data/local_storage/shared_preferences_provider.dart';

import 'package:noti_flutter/talker.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startGuestUserUsecase = ref.watch(startGuestUserUsecaseProvider);
    final sharedPrefs = ref.watch(sharedPreferencesProvider);
    final loginUsecase = ref.watch(logInUsecaseProvider);
    final checkUserUsecase = ref.watch(checkUserUsecaseProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              context.go('/sign_up');
            },
            child: const Text("회원가입 페이지로")),
        ElevatedButton(
            onPressed: () {
              context.go('/log_in');
            },
            child: const Text("로그인 페이지로")),
        ElevatedButton(
            onPressed: () async {
              await loginUsecase.execute(
                  email: "efg11@gmail.com", password: "1q2w3e4r!");
            },
            child: const Text("로그인")),
        ElevatedButton(
            onPressed: () async {
              await checkUserUsecase.execute();
            },
            child: const Text("자동 로그인 체크")),
        ElevatedButton(
            onPressed: () {
              startGuestUserUsecase.execute();
            },
            child: const Text("비회원으로 시작하기")),
        ElevatedButton(
            onPressed: () async {
              final uid = await sharedPrefs.getString("uid");
              talkerLog("test screen", "guest uid : ${uid.toString()}");
            },
            child: const Text("uid 프린트해보기")),
      ],
    );
  }
}
