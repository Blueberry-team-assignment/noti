import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/features/log_in/presentation/providers/user_provider.dart';
import 'package:noti_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final myPageNotifierProvider =
    StateNotifierProvider.family<MyPageNotifier, MyPageState, UserState>(
        (ref, userState) {
  final authRepository = ref.watch(authRepositoryProvider);
  final guestRepository = ref.watch(guestRepositoryProvider);
  return MyPageNotifier(authRepository, userState, guestRepository);
});

class MyPageNotifier extends StateNotifier<MyPageState> {
  final AuthRepository _authRepository;
  final UserState _userState;
  final GuestRepository _guestRepository;

  MyPageNotifier(
    this._authRepository,
    this._userState,
    this._guestRepository,
  ) : super(MyPageState()) {
    state = MyPageState(user: _userState.user);
  }

  Future<void> logout({required bool isAuthUser}) async {
    try {
      if (isAuthUser) {
        await _authRepository.logOut();
      } else {
        await _guestRepository.deleteUid();
      }

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
