import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/dto/sign_up_dto.dart';
import 'package:noti_flutter/data/fire_store/fire_store_repository.dart';
import 'package:noti_flutter/models/user_model.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/common/utils/talker.dart';

/*  비회원 사용자를 로그인 처리하기 위한 서비스 로직.
    1. 임시 uid를 생성하고, fireStore에 저장합니다.
    2. 로그인 체크를 위해 로컬 스토리지에 uid를 저장합니다.
    3. 저장된 유저정보를 반환합니다.
 */
final startGuestUserServiceProvider = Provider<StartGuestUserService>((ref) {
  final fireStoreRepository = ref.watch(fireStoreRepositoryProvider);
  final guestRepository = ref.watch(guestRepositoryProvider);
  return StartGuestUserService(fireStoreRepository, guestRepository);
});

class StartGuestUserService {
  final FireStoreRepository _fireStoreRepository;
  final GuestRepository _guestRepository;

  StartGuestUserService(
    this._fireStoreRepository,
    this._guestRepository,
  );

  // 서비스 이용 요청한 날짜를 토대로 랜덤 uid를 생성하는 메서드
  String _generateRandomUid() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    final randomString = List.generate(
        8, (index) => characters[random.nextInt(characters.length)]).join();
    return '${DateTime.now().toIso8601String()}$randomString';
  }

  Future<UserModel> startGuestUser() async {
    final uid = _generateRandomUid();
    try {
      // 1. 기존에 db에 데이터가 존재하는 게스트인지 확인합니다.
      UserModel? guest =
          await _fireStoreRepository.fetchUserFromFireStore(uid: uid);

      // 2. 처음 로그인한 게스트라면 정보를 firestore에 새로 저장합니다.
      guest ??= await _fireStoreRepository.saveUserToFireStore(
          uid: uid, signUpDto: SignUpDto(isAuthUser: false));

      if (guest == null) throw Exception();
      talkerInfo("startGuestUser", guest.uid);

      // 3. 다음 접속 시, 또다시 게스트 유저를 새로 만들어서 저장하지 않도록 guest의 uid를 로컬 스토리지에 저장합니다.
      await _guestRepository.saveUid(uid: guest.uid.toString());
      talkerInfo("startGuestUserService",
          'guest user logged in : ${guest.toString()}');
      return guest;
    } catch (e) {
      rethrow;
    }
  }
}
