import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/dto/sign_up_dto.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/fire_store/fire_store_repository.dart';
import 'package:noti_flutter/models/user_model.dart';
import 'package:noti_flutter/data/local_storage/shared_preferences_provider.dart';
import 'package:noti_flutter/talker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final startGuestUserUsecaseProvider = Provider<StartGuestUserUsecase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final fireStoreRepository = ref.watch(fireStoreRepositoryProvider);
  final sharedPreferencesAsync = ref.watch(sharedPreferencesProvider);
  return StartGuestUserUsecase(
      authRepository, fireStoreRepository, sharedPreferencesAsync);
});

class StartGuestUserUsecase {
  final AuthRepository _authRepository;
  final FireStoreRepository _fireStoreRepository;
  final SharedPreferencesAsync _sharedPreferencesAsync;

  StartGuestUserUsecase(
    this._authRepository,
    this._fireStoreRepository,
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
      UserModel? guest =
          await _fireStoreRepository.fetchUserFromFireStore(uid: uid);

      guest ??= await _fireStoreRepository.saveUserToFireStore(
          uid: uid, signUpDto: SignUpDto(isAuthUser: false));

      if (guest == null) throw Exception();
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
