import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:noti_flutter/features/fire_store/auth_repository.dart';
import 'package:noti_flutter/model/user_model.dart';

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

  Future<UserModel> execute({
    required String email,
    required String pw,
  }) async {
    // try-catch가 필요할까?
    final user = await _authRepository.logIn(email: email, pw: pw);

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
  }
}
