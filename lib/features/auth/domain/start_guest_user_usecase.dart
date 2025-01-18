import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:noti_flutter/model/user_model.dart';
import 'package:noti_flutter/provider/shared_preferences_provider.dart';
import 'package:noti_flutter/talker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final startGuestUserProvider = Provider<StartGuestUserUsecase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final sharedPreferencesAsync = ref.watch(sharedPreferencesProvider);

  return StartGuestUserUsecase(authRepository, sharedPreferencesAsync);
});

class StartGuestUserUsecase {
  final AuthRepository _authRepository;
  final SharedPreferencesAsync _sharedPreferencesAsync;

  StartGuestUserUsecase(
    this._authRepository,
    this._sharedPreferencesAsync,
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

      if (guest == null) {
        talkerLog("startGuestUserUsecase", "cannot found guest data");
        throw Exception('Failed to start guest user.');
      }

      talkerInfo("startGuestUser", guest.uid);

      await _sharedPreferencesAsync.setString("uid", guest.uid.toString());
      talkerInfo("startGuestUserUsecase",
          'guest user logged in : ${guest.toString()}');
      return guest;
    } catch (e) {
      rethrow;
    }
  }
}
