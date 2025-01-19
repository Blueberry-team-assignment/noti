import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/talker.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
            onChanged: () {
              talkerInfo("sign_up_screen", "form field changed");
            },
            child: Column(
              spacing: 20,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "이름",
                    hintText: "노티에서 사용하실 이름을 입력해주세요",
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "이름을 입력해주세요";
                    }
                    if (text.length < 2) {
                      return "이름은 2글자 이상이어야 합니다.";
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
                  decoration: const InputDecoration(
                    labelText: "비밀번호",
                    hintText: "비밀번호를 입력해주세요",
                  ),
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      talkerInfo(
                          "sign_up_screen", formKey.currentState.toString());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
