import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/log_in_provider.dart';

class LogInScreen extends ConsumerWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final logInState = ref.watch(logInNotifierProvider);
    final logInNotifier = ref.read(logInNotifierProvider.notifier);

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
                  onSaved: (value) {
                    if (value == null || value.isEmpty) return;
                    logInNotifier.setEmailField(email: value);
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "비밀번호",
                    hintText: "비밀번호를 입력해주세요",
                  ),
                  onSaved: (value) {
                    if (value == null || value.isEmpty) return;
                    logInNotifier.setPasswordField(password: value);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    logInNotifier.login(formKey: formKey, context: context);
                  },
                  child: logInState.isLoading
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
