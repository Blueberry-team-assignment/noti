import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/features/auth/data/dto/sign_up_dto.dart';
import 'package:noti_flutter/model/user_model.dart';
import 'package:noti_flutter/provider/talker_provider.dart';
import 'package:talker/talker.dart';

abstract class AuthRepository {
  Future<User?> logIn({
    required String email,
    required String pw,
  });

  Future<User?> signUp({
    required SignUpDto signUpDto,
  });

  Future<UserModel?> saveUserToFireStore({
    required String uid,
    required SignUpDto signUpDto,
  });

  Future<UserModel?> fetchUserFromFireStore({
    required String uid,
  });
}

final authRepositoryProvider = Provider((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final talker = ref.read(talkerProvider);
  return AuthRepositoryImpl(firebaseAuth, firebaseFirestore, talker);
});

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFireStore;
  final Talker _talker;

  AuthRepositoryImpl(
    this._firebaseAuth,
    this._firebaseFireStore,
    this._talker,
  );

  @override
  Future<UserModel?> saveUserToFireStore({
    required String uid,
    required SignUpDto signUpDto,
  }) async {
    try {
      final newUserRef = _firebaseFireStore.collection('users').doc(uid);
      await newUserRef
          .set(signUpDto.toJson())
          .onError((e, _) => _talker.error("Error writing document: $e"));

      final user = await newUserRef.get();

      if (!user.exists) return null;

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
      if (!user.exists) return null;

      final data = user.data() as Map<String, dynamic>;
      data['uid'] = uid;
      return UserModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> signUp({
    required SignUpDto signUpDto,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: signUpDto.email!,
        password: signUpDto.pw!,
      );
      if (userCredential.user == null) {
        _talker.warning('user not logged in');
        throw Exception('user not logged in');
      }

      _talker.info('user signed up : ${userCredential.user?.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _talker.error('The password is too weak.');
        throw Exception('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _talker.error('The account already exists for that email.');
        throw Exception('The account already exists for that email.');
      }
    } catch (e, stackTrace) {
      _talker.error('Unexpected error during signUp : $e', stackTrace);
      rethrow;
    }
    return null;
  }

  @override
  Future<User?> logIn({
    required String email,
    required String pw,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pw,
      );

      final authUser = userCredential.user;
      if (authUser == null) {
        _talker.error('Auth user is null after login.');
        throw FirebaseAuthException(
          code: 'user-not-found',
        );
      }

      _talker.info('user logged in : ${userCredential.user?.uid}');
      return authUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _talker.error('No user found for that email.');
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _talker.error('Wrong password provided.');
        throw Exception('Wrong password provided.');
      }
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('Unexpected error during login: $e', stackTrace);
      rethrow;
    }
  }
}
