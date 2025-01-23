import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/fire_store/fire_store_repository.dart';
import 'package:noti_flutter/models/user_model.dart';

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
