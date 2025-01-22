import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final userState = ref.watch(userNotifierProvider);
    final userNotifier = ref.read(userNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Form(
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
                  onPressed: () {
                    try {
                      if (formKey.currentState!.validate()) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('로그인 중입니다...')),
                          );
                        }

                        userNotifier.login(
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
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          if (context.mounted) {
                            context.replace('/flow');
                          }
                        });
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
        ),
      ),
    );
  }
}
