import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:noti_flutter/features/fire_store/auth_repository.dart';
import 'package:noti_flutter/model/user_model.dart';

final signUpServiceProvider = Provider<SignUpService>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final fireStoreRepository = ref.watch(fireStoreRepositoryProvider);
  return SignUpService(authRepository, fireStoreRepository);
});

class SignUpService {
  final AuthRepository _authRepository;
  final FireStoreRepository _fireStoreRepository;

  SignUpService(
    this._authRepository,
    this._fireStoreRepository,
  );

  Future<UserModel?> execute({
    required SignUpDto signUpDto,
  }) async {
    try {
      final newUser = await _authRepository.signUp(signUpDto: signUpDto);
      if (newUser == null) {
        throw Exception('signed up user not found');
      }

      final authUser = await _fireStoreRepository.saveUserToFireStore(
          uid: newUser.uid, signUpDto: signUpDto);

      return authUser;
    } catch (e) {
      rethrow;
    }
  }
}
