import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/fire_store/fire_store_repository.dart';
import 'package:noti_flutter/models/user_model.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/talker.dart';

final checkUserUsecaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final fireStoreRepository = ref.watch(fireStoreRepositoryProvider);
  final guestRepository = ref.watch(guestRepositoryProvider);
  return CheckUserService(authRepository, fireStoreRepository, guestRepository);
});

class CheckUserService {
  final AuthRepository _authRepository;
  final FireStoreRepository _fireStoreRepository;
  final GuestRepository _guestRepository;

  CheckUserService(
    this._authRepository,
    this._fireStoreRepository,
    this._guestRepository,
  );

  // 비회원 사용자 로그인 되어 있는지 확인
  Future<UserModel?> _checkGuestUser() async {
    try {
      // 비회원으로 로그인한적 있다면, secure storage에 uid 저장되어 있음.
      final guestUid = await _guestRepository.getUid();
      if (guestUid == null) {
        talkerInfo("checkUserService", "stored guest uid is not found");
        return null;
      }

      final guest =
          await _fireStoreRepository.fetchUserFromFireStore(uid: guestUid);

      talkerInfo("checkUserService", "guest logged In : ${guest.toString()}");
      return guest;
    } catch (e) {
      return null;
    }
  }

  // 회원가입한 사용자가 로그인 되어 있는지 확인
  Future<UserModel?> _checkAuthUser() async {
    try {
      final currentUser = _authRepository.checkUser();

      if (currentUser == null) {
        talkerInfo("check_user_service", "로그인 되어있는 유저가 존재하지 않아요");
        return null;
      }

      final authUser = await _fireStoreRepository.fetchUserFromFireStore(
          uid: currentUser.uid);

      talkerInfo(
          "checkUserService", "authUser logged In : ${authUser.toString()}");
      return authUser;
    } catch (e) {
      return null;
    }
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
