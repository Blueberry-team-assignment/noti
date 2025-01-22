import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/models/user_model.dart';

final myPageNotifierProvider =
    StateNotifierProvider<MyPageNotifier, MyPageState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return MyPageNotifier(authRepository);
});

class MyPageNotifier extends StateNotifier<MyPageState> {
  final AuthRepository _authRepository;

  MyPageNotifier(
    this._authRepository,
  ) : super(MyPageState());

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
