import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/dto/sign_up_dto.dart';
import 'package:noti_flutter/common/utils/talker.dart';

/* 사용자 인증을 위한 레포지토리.
  firebaseAuth에 요청을 보내 로그인/로그아웃/로그인체크/회원가입 기능을 처리합니다. 
 */

final authRepositoryProvider = Provider((ref) {
  final firebaseAuth = FirebaseAuth.instance;

  return AuthRepositoryImpl(firebaseAuth);
});

abstract class AuthRepository {
  Future<User> logIn({
    required String email,
    required String password,
  });

  Future<User?> signUp({
    required SignUpDto signUpDto,
  });

  User? checkUser();

  Future<void> logOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(
    this._firebaseAuth,
  );

  @override
  Future<User?> signUp({
    required SignUpDto signUpDto,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: signUpDto.email!,
        password: signUpDto.password!,
      );
      if (userCredential.user == null) {
        talkerLog(
          "authRepository(signUp)",
          "회원가입한 유저의 정보를 불러 올 수 없습니다",
        );
        throw Exception('user not logged in');
      }

      talkerInfo("authRepository(signUp)",
          'user signed up : ${userCredential.user?.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        talkerError("authRepository(signUp) ", 'The password is too weak.', e);
        throw Exception('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        talkerError("authRepository(signUp)",
            'The account already exists for that email.', e);
        throw Exception('The account already exists for that email.');
      }
    } catch (e, stackTrace) {
      talkerError("authRepository(signUp)",
          'Unexpected error during signUp : $e', stackTrace);
      rethrow;
    }
    return null;
  }

  @override
  Future<User> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final authUser = userCredential.user;
      if (authUser == null) {
        talkerLog("authRepository(logIn)", 'Auth user is null after login.');
        throw FirebaseAuthException(
          code: 'user-not-found',
        );
      }

      talkerInfo("authRepository(logIn)",
          'user logged in : ${userCredential.user?.uid}');
      return authUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        talkerError(
            "authRepository(logIn)", 'No user found for that email.', e);
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        talkerError("authRepository(logIn)", 'Wrong password provided.', e);
        throw Exception('Wrong password provided.');
      }
      rethrow;
    } catch (e, stackTrace) {
      talkerError(
          "authRepository(logIn)", 'Wrong password provided. : $e', stackTrace);
      rethrow;
    }
  }

  @override
  User? checkUser() {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) throw Exception('User not found');
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
