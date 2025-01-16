import 'dart:math';

import 'package:noti_flutter/features/login/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/login/data/repositories/auth_repository.dart';
import 'package:noti_flutter/model/user_model.dart';

class StartGuestUserUsecase {
  final AuthRepository _authRepository;

  StartGuestUserUsecase(
    this._authRepository,
  );

  String _generateRandomUid() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    final randomString = List.generate(
        8, (index) => characters[random.nextInt(characters.length)]).join();
    return '${DateTime.now().toIso8601String()}$randomString';
  }

  Future<UserModel> execute() async {
    final uid = _generateRandomUid();
    try {
      UserModel? guest = await _authRepository.fetchUserFromFireStore(uid: uid);

      guest ??= await _authRepository.saveUserToFireStore(
          uid: uid, signUpDto: SignUpDto(isAuthUser: false));

      return guest!;
    } catch (e) {
      rethrow;
    }
  }
}
