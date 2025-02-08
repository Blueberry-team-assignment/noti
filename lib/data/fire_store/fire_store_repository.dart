import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/dto/sign_up_dto.dart';
import 'package:noti_flutter/models/user_model.dart';
import 'package:noti_flutter/common/utils/talker.dart';

/*  사용자의 정보를 fireStore에 저장/조회 위한 레포지토리.
    authRepository의 메서드로 회원가입/로그인 시 uid를 얻으며,
    이 uid를 통해 user컬렉션의 문서를 식별하여 로그인한 사용자의 정보를 조회/저장합니다.
 */

final fireStoreRepositoryProvider = Provider((ref) {
  final firebaseFirestore = FirebaseFirestore.instance;

  return FireStoreRepositoryImpl(firebaseFirestore);
});

abstract class FireStoreRepository {
  Future<UserModel?> saveUserToFireStore({
    required String uid,
    required SignUpDto signUpDto,
  });

  Future<UserModel?> fetchUserFromFireStore({
    required String uid,
  });
}

class FireStoreRepositoryImpl implements FireStoreRepository {
  final FirebaseFirestore _firebaseFireStore;

  FireStoreRepositoryImpl(
    this._firebaseFireStore,
  );

  @override
  Future<UserModel?> saveUserToFireStore({
    required String uid,
    required SignUpDto signUpDto,
  }) async {
    try {
      final newUserRef = _firebaseFireStore.collection('users').doc(uid);
      await newUserRef.set(signUpDto.toJson()).onError((e, _) => talkerError(
          "authRepository(saveUserToFireStore)",
          "유저 정보를 firestore에 저장하는 데 실패했습니다",
          e ?? {}));

      final user = await newUserRef.get();

      if (!user.exists) {
        talkerInfo("authRepository(saveUserToFireStore)",
            "saved user from firestore not found");
        return null;
      }

      final data = user.data() as Map<String, dynamic>;
      data['uid'] = uid;
      return UserModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel?> fetchUserFromFireStore({
    required String uid,
  }) async {
    try {
      final docRef = _firebaseFireStore.collection("users").doc(uid);

      final user = await docRef.get();
      if (!user.exists) {
        talkerInfo("authRepository(fetchUserToFireStore)",
            "fetched user from firestore not found");
        return null;
      }

      final data = user.data() as Map<String, dynamic>;
      data['uid'] = uid;
      return UserModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }
}
