import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/model/user_model.dart';
import 'package:noti_flutter/provider/talker_provider.dart';
import 'package:talker/talker.dart';

abstract class LoginRepository {
  Future<UserModel> login({
    required String email,
    required String pw,
  });
}

final loginRepositoryProvider = Provider((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  final talker = ref.read(talkerProvider);
  return LoginRepositoryImpl(firebaseAuth, talker);
});

class LoginRepositoryImpl implements LoginRepository {
  final FirebaseAuth _firebaseAuth;
  final Talker _talker;

  LoginRepositoryImpl(
    this._firebaseAuth,
    this._talker,
  );

  @override
  Future<UserModel> login({
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

      final uid = authUser.uid;

      // firebase에서 uid로 유저 정보 가져오기
      final userFromFireStore = {};
      return UserModel.fromJson(userFromFireStore as Map<String, dynamic>);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _talker.warning('No user found for that email.');
        throw Exception('No user found for the provided email.');
      } else if (e.code == 'wrong-password') {
        _talker.warning('Wrong password provided for that user.');
        throw Exception('Wrong password provided.');
      }
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('Unexpected error during login: $e', stackTrace);
      rethrow;
    }
  }
}
