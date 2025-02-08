import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';
import 'package:noti_flutter/services/local_notification.dart';
import 'package:noti_flutter/common/utils/talker.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateProvider);
    final userStateNotifier = ref.read(userStateProvider.notifier);
    final guestRepository = ref.watch(guestRepositoryProvider);

    // 로그인 요청이 성공하여 userState에 유저정보가 저장되면, HomeScreen으로 이동시킵니다.
    ref.listen(userStateProvider, (prev, next) {
      if (next.user != null) {
        context.go('/home');
      }
    });

    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            spacing: 20,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "이메일",
                  hintText: "이메일을 입력해주세요",
                ),
                controller: _emailController,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "비밀번호",
                  hintText: "비밀번호를 입력해주세요",
                ),
                controller: _passwordController,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (formKey.currentState!.validate()) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('로그인 중입니다...')),
                        );
                      }

                      await userStateNotifier.login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('로그인 되었습니다.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: userState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('LogIn'),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                userStateNotifier.startGuestUser();
              },
              child: const Text("비회원으로 시작하기"),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/sign_up');
              },
              child: const Text("회원가입"),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            final uid = await guestRepository.getUid();
            talkerLog("test screen", "guest uid : ${uid.toString()}");
          },
          child: const Text("uid 프린트해보기"),
        ),
        ElevatedButton(
          onPressed: () async {
            NotificationDetails details = const NotificationDetails(
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
              android: AndroidNotificationDetails(
                "99",
                "test",
                importance: Importance.max,
                priority: Priority.high,
              ),
            );

            ref
                .watch(localNotificationProvider)
                .show(99, "title", "body", details);
          },
          child: const Text("알림 발송하기"),
        ),
      ],
    );
  }
}
