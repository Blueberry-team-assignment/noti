import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/features/log_in/domain/check_user_service.dart';
import 'package:noti_flutter/features/log_in/domain/log_in_usecase.dart';
import 'package:noti_flutter/features/log_in/domain/start_guest_user_service.dart';
import 'package:noti_flutter/models/user_model.dart';

/*  사용자의 인증관련 상태를 관리하기 위한 프로바이더.
    LogInScreen에서 사용자의 인증관련 메서드를 처리하고,
    로그인한 사용자의 상태를 다른 화면에 제공하는 역할을 합니다.
 */
final userStateProvider =
    StateNotifierProvider.autoDispose<UserStateNotifier, UserState>((ref) {
  final logInUsecase = ref.watch(logInUsecaseProvider);
  final checkUserService = ref.watch(checkUserServiceProvider);
  final startGuestUserService = ref.watch(startGuestUserServiceProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final guestRepository = ref.watch(guestRepositoryProvider);
  return UserStateNotifier(logInUsecase, checkUserService,
      startGuestUserService, authRepository, guestRepository);
});

class UserStateNotifier extends StateNotifier<UserState> {
  final LogInUsecase _logInUsecase;
  final CheckUserService _checkUserService;
  final StartGuestUserService _startGuestUserService;
  final AuthRepository _authRepository;
  final GuestRepository _guestRepository;

  UserStateNotifier(
    this._logInUsecase,
    this._checkUserService,
    this._startGuestUserService,
    this._authRepository,
    this._guestRepository,
  ) : super(UserState()) {
    checkUserState();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      setLoading(true);

      final authUser =
          await _logInUsecase.execute(email: email, password: password);
      if (authUser == null) {
        return;
      }

      state = UserState(user: authUser);
    } catch (e) {
      setLoading(false);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      if (state.user == null) return;

      if (state.user!.isAuthUser) {
        await _authRepository.logOut();
      } else {
        await _guestRepository.deleteUid();
      }

      state = UserState(user: null);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkUserState() async {
    try {
      setLoading(true);

      final user = await _checkUserService.checkUser();

      state = UserState(user: user);
    } catch (e) {
      setLoading(false);
    }
  }

  Future<void> startGuestUser() async {
    try {
      setLoading(true);

      final guest = await _startGuestUserService.startGuestUser();

      state = UserState(user: guest);
    } catch (e) {
      setLoading(false);
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
