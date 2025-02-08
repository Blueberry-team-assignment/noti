import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/fire_store/fire_store_repository.dart';
import 'package:noti_flutter/models/user_model.dart';

/*  회원 사용자의 로그인을 처리하는 유스케이스.
    1. 사용자가 입력한 이메일과 비밀번호로 fireAuth의 singIn을 요청합니다.
    2. fireStore의 유저정보를 불러온 뒤 모델로 변환해 userState에 넣어줍니다.
 */
final logInUsecaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final fireStoreRepository = ref.watch(fireStoreRepositoryProvider);
  return LogInUsecase(authRepository, fireStoreRepository);
});

class LogInUsecase {
  final AuthRepository _authRepository;
  final FireStoreRepository _fireStoreRepository;

  LogInUsecase(
    this._authRepository,
    this._fireStoreRepository,
  );

  Future<UserModel?> execute({
    required String email,
    required String password,
  }) async {
    try {
      final user =
          await _authRepository.logIn(email: email, password: password);

      final authUser =
          await _fireStoreRepository.fetchUserFromFireStore(uid: user.uid);
      if (authUser == null) {
        throw Exception("cannot fetched user from firestore");
      }

      return UserModel(
        uid: authUser.uid,
        isAuthUser: true,
        email: authUser.email,
        name: authUser.name,
        recentFlowHistoryIds: authUser.recentFlowHistoryIds,
      );
    } catch (e) {
      rethrow;
    }
  }
}
