import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/fire_store/fire_store_repository.dart';
import 'package:noti_flutter/models/user_model.dart';
import 'package:noti_flutter/data/local_storage/shared_preferences_provider.dart';
import 'package:noti_flutter/talker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final checkUserUsecaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final fireStoreRepository = ref.watch(fireStoreRepositoryProvider);
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return CheckUserService(
      authRepository, fireStoreRepository, sharedPreferences);
});

class CheckUserService {
  final AuthRepository _authRepository;
  final FireStoreRepository _fireStoreRepository;
  final SharedPreferencesAsync _sharedPreferencesAsync;

  CheckUserService(
    this._authRepository,
    this._fireStoreRepository,
    this._sharedPreferencesAsync,
  );

  Future<UserModel?> _checkGuestUser() async {
    // 비회원으로 로그인한적 있다면, sharedPreferences에 uid 저장되어 있음.
    final guestUid = await _sharedPreferencesAsync.getString("uid");
    if (guestUid == null) {
      talkerInfo("checkUserService", "stored guest uid is not found");
      return null;
    }

    final guest =
        await _fireStoreRepository.fetchUserFromFireStore(uid: guestUid);

    talkerInfo("checkUserService", "guest logged In : ${guest.toString()}");
    return guest;
  }

  Future<UserModel?> _checkAuthUser() async {
    final currentUser = await _authRepository.checkUser();
    if (currentUser == null) {
      talkerInfo("check_user_service", "로그인 되어있는 유저가 존재하지 않아요");
      return null;
    }

    final authUser =
        await _fireStoreRepository.fetchUserFromFireStore(uid: currentUser.uid);

    talkerInfo(
        "checkUserService", "authUser logged In : ${authUser.toString()}");
    return authUser;
  }

  Future<UserModel?> checkUser() async {
    try {
      final authUser = await _checkAuthUser();
      if (authUser == null) {
        return await _checkGuestUser();
      }
      return authUser;
    } catch (e) {
      rethrow;
    }
  }
}
