import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/features/flow/presentation/home/flow_list_provider.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';
import 'package:noti_flutter/talker.dart';

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
    final userState = ref.watch(userNotifierProvider);
    final userNotifier = ref.read(userNotifierProvider.notifier);
    final flowListNotifier = ref.read(flowListProvider.notifier);
    final guestRepository = ref.watch(guestRepositoryProvider);

    ref.listen(userNotifierProvider, (prev, next) {
      talkerInfo("loginScreen",
          "prev: ${prev?.user.toString()}, isLoading :${prev?.isLoading}, next: ${next.user.toString()}, isLoading :${next.isLoading}");
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

                      await userNotifier.login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
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
                          duration: const Duration(seconds: 20),
                          action: SnackBarAction(
                            label: '닫기',
                            textColor: Colors.white,
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
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
                userNotifier.startGuestUser();
              },
              child: const Text("비회원으로 시작하기"),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/sign_up');
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
      ],
    );
  }
}
