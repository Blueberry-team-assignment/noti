import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/log_in/domain/check_user_service.dart';
import 'package:noti_flutter/features/log_in/domain/log_in_usecase.dart';
import 'package:noti_flutter/models/user_model.dart';

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) {
  final logInUsecase = ref.watch(logInUsecaseProvider);
  final checkUserService = ref.watch(checkUserUsecaseProvider);
  return UserNotifier(logInUsecase, checkUserService);
});

class UserNotifier extends StateNotifier<UserState> {
  final LogInUsecase _logInUsecase;
  final CheckUserService _checkUserService;

  UserNotifier(
    this._logInUsecase,
    this._checkUserService,
  ) : super(UserState()) {
    checkUserState();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      setLoading(true);

      await _logInUsecase.execute(email: email, password: password);

      setLoading(false);
    } catch (e) {
      setLoading(false);
      rethrow;
    }
  }

  Future<void> checkUserState() async {
    try {
      setLoading(true);

      final user = await _checkUserService.checkUser();

      state = UserState(user: user);
    } catch (e) {
      setLoading(true);
      rethrow;
    }
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }
}

class UserState {
  UserModel? user;
  bool isLoading;

  UserState({
    this.user,
    this.isLoading = false,
  });

  UserState copyWith({
    UserModel? user,
    bool? isLoading,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
