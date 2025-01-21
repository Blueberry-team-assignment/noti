import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/auth/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/auth/domain/sign_up_service.dart';
import 'package:noti_flutter/features/auth/presentation/providers/states/sign_up_state.dart';
import 'package:noti_flutter/talker.dart';

final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  final signUpService = ref.watch(signUpServiceProvider);
  return SignUpNotifier(signUpService);
});

class SignUpNotifier extends StateNotifier<SignUpState> {
  final SignUpService _signUpService;

  SignUpNotifier(
    this._signUpService,
  ) : super(SignUpState());

  Future<void> signUp({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      if (formKey.currentState!.validate()) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('회원가입이 진행 중입니다...')),
          );
        }
        formKey.currentState!.save();

        final authUser = await _signUpService.execute(
            signUpDto: SignUpDto(
          isAuthUser: true,
          name: state.name,
          password: state.password,
          email: state.email,
        ));

        if (context.mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('회원가입이 완료되었습니다.'),
              backgroundColor: Colors.green,
            ),
          );
        }
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (context.mounted) {
            context.go("/");
          }
        });

        talkerInfo(
            "signUpProvider", "authUser signed up : ${authUser.toString()}");
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);

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
      // rethrow;
    }
  }

  void saveNameField({required String name}) {
    state = state.copyWith(name: name);
  }

  void savePasswordField({required String password}) {
    state = state.copyWith(password: password);
  }

  void saveEmailField({required String email}) {
    state = state.copyWith(email: email);
  }
}
