import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final guestRepositoryProvider = Provider((ref) {
  const secureStorage = FlutterSecureStorage();
  return GuestRepositoryImpl(secureStorage);
});

abstract class GuestRepository {
  Future<void> saveUid({required String uid});

  Future<String?> getUid();

  Future<void> deleteUid();
}

class GuestRepositoryImpl implements GuestRepository {
  final FlutterSecureStorage _secureStorage;

  GuestRepositoryImpl(
    this._secureStorage,
  );

  // uidKey가 이 클래스의 인스턴스와 상관없이 하나만 존재함을 의미.
  static const String _uidKey = "uid";

  @override
  Future<void> saveUid({required String uid}) async {
    await _secureStorage.write(key: _uidKey, value: uid);
  }

  @override
  Future<String?> getUid() async {
    try {
      return await _secureStorage.read(key: _uidKey);
    } catch (e) {
      return null;
    }
  }

  // 로그아웃 시 uid 삭제 (
  @override
  Future<void> deleteUid() async {
    await _secureStorage.delete(key: _uidKey);
  }
}
