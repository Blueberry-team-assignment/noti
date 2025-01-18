import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:noti_flutter/model/user_model.dart';

final logInProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LogInUsecase(authRepository);
});

class LogInUsecase {
  final AuthRepository _authRepository;

  LogInUsecase(
    this._authRepository,
  );

  Future<UserModel> execute({
    required String email,
    required String pw,
  }) async {
    // try-catch가 필요할까?
    final user = await _authRepository.logIn(email: email, pw: pw);

    final authUser =
        await _authRepository.fetchUserFromFireStore(uid: user.uid);
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
