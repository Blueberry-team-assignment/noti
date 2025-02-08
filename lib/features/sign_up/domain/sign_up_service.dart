import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/dto/sign_up_dto.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/fire_store/fire_store_repository.dart';
import 'package:noti_flutter/models/user_model.dart';

/*  회원가입을 처리하기 위한 서비스 로직.
    1. signUpScreen에서 입력된 이메일과 패스워드를 들고 fireAuth의 signUp을 요청합니다.
    2. 회원가입이 성공하면, 유저정보를 fireStore에 저장합니다.
 */
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

  Future<UserModel?> signUpAndSave({
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
