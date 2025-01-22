import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';
import 'package:noti_flutter/models/user_model.dart';

final myPageNotifierProvider =
    StateNotifierProvider.family<MyPageNotifier, MyPageState, UserState>(
        (ref, userState) {
  final authRepository = ref.watch(authRepositoryProvider);
  return MyPageNotifier(authRepository, userState);
});

class MyPageNotifier extends StateNotifier<MyPageState> {
  final AuthRepository _authRepository;
  final UserState _userState;

  MyPageNotifier(
    this._authRepository,
    this._userState,
  ) : super(MyPageState()) {
    state = MyPageState(user: _userState.user);
  }

  Future<void> logout() async {
    try {
      await _authRepository.logOut();

      state = MyPageState(isLoading: false);
    } catch (e) {
      rethrow;
    }
  }
}

class MyPageState {
  UserModel? user;
  bool isLoading;
  // List<>

  MyPageState({
    this.user,
    this.isLoading = false,
  });
}
