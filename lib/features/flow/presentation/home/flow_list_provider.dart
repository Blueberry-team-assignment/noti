import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/flow/flow_repository.dart';
import 'package:noti_flutter/data/local_storage/shared_preferences_provider.dart';
import 'package:noti_flutter/models/flow_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final flowListProvider =
    StateNotifierProvider<FlowListNotifier, AsyncValue<List<FlowModel>>>((ref) {
  final flowRepository = ref.watch(flowRepositoryProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final sharedPreference = ref.watch(sharedPreferencesProvider);
  return FlowListNotifier(flowRepository, authRepository, sharedPreference);
});

class FlowListNotifier extends StateNotifier<AsyncValue<List<FlowModel>>> {
  final FlowRepository _flowRepository;
  final AuthRepository _authRepository;
  final SharedPreferencesAsync _sharedPreferencesAsync;

  FlowListNotifier(
    this._flowRepository,
    this._authRepository,
    this._sharedPreferencesAsync,
  ) : super(const AsyncValue.loading());

  Future<void> loadFlowList({required bool isAuthUser}) async {
    try {
      state = const AsyncValue.loading();

      final uid = isAuthUser
          ? _authRepository.checkUser()?.uid
          : await _sharedPreferencesAsync.getString("uid");
      if (uid == null || uid == "") {
        throw Exception("uid not found");
      }

      final flowList = await _flowRepository.getFlowList(uid: uid);

      state = AsyncValue.data(flowList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
