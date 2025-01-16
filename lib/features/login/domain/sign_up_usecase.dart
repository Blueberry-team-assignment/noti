import 'package:noti_flutter/features/login/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/login/data/repositories/auth_repository.dart';
import 'package:noti_flutter/model/user_model.dart';

class SignUpUsecase {
  final AuthRepository _authRepository;

  SignUpUsecase(
    this._authRepository,
  );

  Future<UserModel?> execute({
    required SignUpDto signUpDto,
  }) async {
    try {
      final newUser = await _authRepository.signUp(signUpDto: signUpDto);
      if (newUser == null) {
        throw Exception('signed up user not found');
      }

      final authUser = await _authRepository.saveUserToFireStore(
          uid: newUser.uid, signUpDto: signUpDto);

      return authUser;
    } catch (e) {
      rethrow;
    }
  }
}
