import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/flow/flow_repository.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/models/flow_model.dart';

/* 사용자가 등록한 플로우의 목록을 제공하기 위한 프로바이더.
  asyncValue로 프로바이더의 상태를 초기화하고, HomeScreen에서 when문을 사용하여
  비동기로 전달되는 플로우 목록을 사용자에게 안전하게 제공합니다. 
 */
final flowListProvider = StateNotifierProvider.autoDispose<FlowListNotifier,
    AsyncValue<List<FlowModel>>>((ref) {
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
  ) : super(const AsyncValue.loading()) {
    loadFlowList();
  }

  Future<void> loadFlowList() async {
    try {
      state = const AsyncValue.loading();

      final uid =
          await _guestRepository.getUid() ?? _authRepository.checkUser()?.uid;

      if (uid == null || uid == "") {
        throw Exception("uid not found");
      }

      final flowList = await _flowRepository.getFlowList(uid: uid);

      if (mounted) {
        state = AsyncValue.data(flowList);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
