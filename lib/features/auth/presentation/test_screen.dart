import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:noti_flutter/features/auth/domain/sign_up_usecase.dart';
import 'package:noti_flutter/features/auth/domain/start_guest_user_usecase.dart';
import 'package:noti_flutter/provider/shared_preferences_provider.dart';

import 'package:noti_flutter/talker.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authRepositoryProvider);
    final signup = ref.watch(signUpUsecaseProvider);
    final startGuestUserUsecase = ref.watch(startGuestUserProvider);
    final sharedPrefs = ref.read(sharedPreferencesProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () async {
              final user = await signup.execute(
                  signUpDto: SignUpDto(
                      email: "efg11@gmail.com",
                      pw: "1q2w3e4r!",
                      name: "testuser",
                      isAuthUser: true));
            },
            child: const Text("회원가입")),
        ElevatedButton(
            onPressed: () async {
              final user = await authNotifier.logIn(
                  email: "efg11@gmail.com", pw: "1q2w3e4r!");
            },
            child: const Text("로그인")),
        ElevatedButton(
            onPressed: () {
              startGuestUserUsecase.execute();
            },
            child: const Text("비회원으로 시작하기")),
        ElevatedButton(
            onPressed: () async {
              await sharedPrefs.setString("uid", "1234");
              final uid = await sharedPrefs.getString("uid");
              talkerLog("test screen", "uid : ${uid.toString()}");
            },
            child: const Text("uid 저장하기")),
      ],
    );
  }
}
