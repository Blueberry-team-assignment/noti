import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:noti_flutter/router/go_router.dart';
import 'package:noti_flutter/talker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final signUpNotifier = ref.read(signUpNotifierProvider.notifier);
    final signUpState = ref.watch(signUpNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
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
                    labelText: "이름",
                    hintText: "노티에서 사용하실 이름을 입력해주세요",
                  ),
                  onSaved: (value) {
                    if (value == null || value.isEmpty) return;
                    signUpNotifier.saveNameField(name: value);
                  },
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "이름을 입력해주세요";
                    }
                    if (text.length < 2 || text.length > 8) {
                      return "이름은 2글자 이상 8글자 이하여야 합니다.";
                    }
                    // 영어, 한글, 숫자만 허용하는 정규식
                    final allowedCharactersRegex = RegExp(r'^[a-zA-Z가-힣0-9]+$');
                    if (!allowedCharactersRegex.hasMatch(text)) {
                      return "이름은 영어, 한글, 숫자만 입력 가능합니다.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "이메일",
                    hintText: "이메일을 입력해주세요",
                  ),
                  onSaved: (value) {
                    if (value == null || value.isEmpty) return;
                    signUpNotifier.saveEmailField(email: value);
                  },
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "이메일을 입력해주세요.";
                    }
                    // 간단한 이메일 형식 체크
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!emailRegex.hasMatch(text)) {
                      return "유효한 이메일 형식을 입력해주세요.";
                    }
                    return null;
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
                    signUpNotifier.savePasswordField(password: value);
                  },
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "비밀번호를 입력해주세요.";
                    }
                    if (text.length < 8) {
                      return "비밀번호는 8자 이상이어야 합니다.";
                    }
                    if (!RegExp(r'[A-Za-z]').hasMatch(text) ||
                        !RegExp(r'\d').hasMatch(text)) {
                      return "비밀번호는 문자와 숫자를 포함해야 합니다.";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (context.mounted) {
                        showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.info(
                                message: "회원가입이 진행 중입니다..."));
                      }
                      formKey.currentState!.save();
                      await signUpNotifier.signUp();
                      if (context.mounted) {
                        showTopSnackBar(
                            displayDuration: const Duration(milliseconds: 2000),
                            Overlay.of(context),
                            const CustomSnackBar.success(
                                message: "회원가입이 완료되었습니다."));
                      }
                      Future.delayed(const Duration(milliseconds: 2000), () {
                        if (context.mounted) {
                          context.go("/");
                        }
                      });
                    }
                  },
                  child: signUpState.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
