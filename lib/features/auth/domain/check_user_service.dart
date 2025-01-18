import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:noti_flutter/model/user_model.dart';
import 'package:noti_flutter/provider/shared_preferences_provider.dart';
import 'package:noti_flutter/talker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final checkUserProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return CheckUserService(authRepository, sharedPreferences);
});

class CheckUserService {
  final AuthRepository _authRepository;
  final SharedPreferencesAsync _sharedPreferencesAsync;

  CheckUserService(
    this._authRepository,
    this._sharedPreferencesAsync,
  );

  Future<UserModel?> checkGuestUser() async {
    // 비회원으로 로그인한적 있다면, sharedPreferences에 uid 저장되어 있음.
    final guestUid = await _sharedPreferencesAsync.getString("uid");
    if (guestUid == null) {
      talkerInfo("checkUserService", "stored guest uid is not found");
      return null;
    }

    final guest = await _authRepository.fetchUserFromFireStore(uid: guestUid);

    talkerInfo("checkUserService", "guest logged In : ${guest.toString()}");
    return guest;
  }

  Future<UserModel?> checkAuthUser() async {
    final currentUser = await _authRepository.checkUser();
    if (currentUser == null) {
      return null;
    }

    final authUser =
        await _authRepository.fetchUserFromFireStore(uid: currentUser.uid);

    talkerInfo(
        "checkUserService", "authUser logged In : ${authUser.toString()}");
    return authUser;
  }

  Future<UserModel?> execute() async {
    final authUser = await checkAuthUser();
    if (authUser == null) {
      return await checkGuestUser();
    }
    return authUser;
  }
}
