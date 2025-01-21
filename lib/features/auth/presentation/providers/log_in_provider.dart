import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/auth/domain/log_in_usecase.dart';
import 'package:noti_flutter/features/auth/domain/sign_up_service.dart';
import 'package:noti_flutter/features/auth/presentation/providers/states/log_in_state.dart';
import 'package:noti_flutter/features/auth/presentation/providers/states/sign_up_state.dart';
import 'package:noti_flutter/talker.dart';

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

  Future<void> login() async {
    try {
      state = state.copyWith(isLoading: true);

      await _logInUsecase.execute(email: state.email, password: state.password);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  void setEmailField({required String email}) {
    state = state.copyWith(email: email);
  }

  void setPasswordField({required String password}) {
    state = state.copyWith(password: password);
  }
}
