import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/sign_up/domain/sign_up_service.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 20,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "이름",
              hintText: "노티에서 사용하실 이름을 입력해주세요",
            ),
            controller: _nameController,
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
            controller: _emailController,
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
            controller: _passwordController,
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
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: Theme.of(context).colorScheme.inverseSurface,
            ),
            onPressed: () async {
              isLoading = true;
              try {
                if (formKey.currentState!.validate()) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('회원가입이 진행 중입니다...')),
                    );
                  }

                  // signUpService를 호출하는 것 외에 복잡한 상태관리가 필요없기 때문에
                  // 별도의 provider를 만들지 않고 signUpService를 직접 호출합니다.
                  await ref.watch(signUpServiceProvider).signUpAndSave(
                        signUpDto: SignUpDto(
                          isAuthUser: true,
                          name: _nameController.text,
                          password: _passwordController.text,
                          email: _emailController.text,
                        ),
                      );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('회원가입이 완료되었습니다.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }

                  // 부드러운 화면전환을 위해 딜레이 설정.
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    if (context.mounted) {
                      context.go("/log_in");
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
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                }
              } finally {
                isLoading = false;
              }
            },
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(
                    '회원가입',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          ),
          TextButton(
            onPressed: () {
              context.pushReplacement('/log_in');
            },
            child: Text(
              "돌아가기",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
