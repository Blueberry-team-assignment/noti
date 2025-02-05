import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/flow/flow_repository.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/models/flow_model.dart';

final flowListProvider =
    StateNotifierProvider<FlowListNotifier, AsyncValue<List<FlowModel>>>((ref) {
  final flowRepository = ref.watch(flowRepositoryProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final guestRepository = ref.watch(guestRepositoryProvider);
  return FlowListNotifier(flowRepository, authRepository, guestRepository);
});

class FlowListNotifier extends StateNotifier<AsyncValue<List<FlowModel>>> {
  final FlowRepository _flowRepository;
  final AuthRepository _authRepository;
  final GuestRepository _guestRepository;

  FlowListNotifier(
    this._flowRepository,
    this._authRepository,
    this._guestRepository,
  ) : super(const AsyncValue.loading());

  Future<void> loadFlowList() async {
    try {
      state = const AsyncValue.loading();

      final uid =
          await _guestRepository.getUid() ?? _authRepository.checkUser()?.uid;
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
