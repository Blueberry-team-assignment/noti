import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noti_flutter/features/auth/domain/log_in_usecase.dart';
import 'package:noti_flutter/features/auth/presentation/providers/states/log_in_state.dart';

final logInNotifierProvider =
    StateNotifierProvider<LogInNotifier, LogInState>((ref) {
  final logInUsecase = ref.watch(logInUsecaseProvider);
  return LogInNotifier(logInUsecase);
});

class LogInNotifier extends StateNotifier<LogInState> {
  final LogInUsecase _logInUsecase;

  LogInNotifier(
    this._logInUsecase,
  ) : super(LogInState());

  Future<void> login({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      if (formKey.currentState!.validate()) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('로그인 중입니다...')),
          );
        }
        formKey.currentState!.save();

        await _logInUsecase.execute(
            email: state.email, password: state.password);

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
            context.go('/flow');
          }
        });
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

  void setEmailField({required String email}) {
    state = state.copyWith(email: email);
  }

  void setPasswordField({required String password}) {
    state = state.copyWith(password: password);
  }
}
