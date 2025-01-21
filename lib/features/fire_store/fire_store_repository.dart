import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/model/user_model.dart';
import 'package:noti_flutter/talker.dart';

abstract class FireStoreRepository {
  Future<UserModel?> saveUserToFireStore({
    required String uid,
    required SignUpDto signUpDto,
  });

  Future<UserModel?> fetchUserFromFireStore({
    required String uid,
  });
}

final fireStoreRepositoryProvider = Provider((ref) {
  final firebaseFirestore = FirebaseFirestore.instance;

  return FireStoreRepositoryImpl(firebaseFirestore);
});

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
