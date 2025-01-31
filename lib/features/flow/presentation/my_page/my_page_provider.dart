import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/local_storage/shared_preferences_provider.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';
import 'package:noti_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final myPageNotifierProvider =
    StateNotifierProvider.family<MyPageNotifier, MyPageState, UserState>(
        (ref, userState) {
  final authRepository = ref.watch(authRepositoryProvider);
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return MyPageNotifier(authRepository, userState, sharedPreferences);
});

class MyPageNotifier extends StateNotifier<MyPageState> {
  final AuthRepository _authRepository;
  final UserState _userState;
  final SharedPreferencesAsync _sharedPreferencesAsync;

  MyPageNotifier(
    this._authRepository,
    this._userState,
    this._sharedPreferencesAsync,
  ) : super(MyPageState()) {
    state = MyPageState(user: _userState.user);
  }

  Future<void> logout() async {
    try {
      await _authRepository.logOut();

      await _sharedPreferencesAsync.remove("uid");

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
