import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';

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
      spacing: 20,
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
              // const SizedBox(
              //   height: 5,
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary),
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
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircularProgressIndicator(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      )
                    : Text(
                        '로그인',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                userStateNotifier.startGuestUser();
              },
              child: Text(
                "비회원으로 시작하기",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.go('/sign_up');
              },
              child: Text(
                "회원가입",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
