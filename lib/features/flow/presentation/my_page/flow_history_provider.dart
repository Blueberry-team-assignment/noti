import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/flow/flow_history_repository.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/dto/flow_history_dto.dart';
import 'package:noti_flutter/models/flow_history_model.dart';
import 'package:noti_flutter/talker.dart';

final flowHistoryProvider = StateNotifierProvider<FlowHistoryNotifier,
    AsyncValue<List<FlowHistoryModel>>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final guestRepository = ref.watch(guestRepositoryProvider);
  final flowHistoryRepository = ref.watch(flowHistoryRepositoryProvider);
  return FlowHistoryNotifier(
      authRepository, guestRepository, flowHistoryRepository);
});

class FlowHistoryNotifier
    extends StateNotifier<AsyncValue<List<FlowHistoryModel>>> {
  final AuthRepository _authRepository;
  final GuestRepository _guestRepository;
  final FlowHistoryRepository _flowHistoryRepository;

  FlowHistoryNotifier(
    this._authRepository,
    this._guestRepository,
    this._flowHistoryRepository,
  ) : super(const AsyncValue.loading());

  Future<void> fetchFlowHistories() async {
    try {
      // 1. user컬렉션의 문서를 식별하기 위한 uid 세팅.
      final uid =
          await _guestRepository.getUid() ?? _authRepository.checkUser()?.uid;
      if (uid == null || uid == "") {
        throw Exception("uid not found");
      }

      // 2. 데이터 요청
      final flowHistories =
          await _flowHistoryRepository.getFlowHistories(uid: uid);

      // 3. 상태에 저장
      if (mounted) {
        state = AsyncValue.data(flowHistories);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createFlowHistory({
    required FlowHistoryDto flowHistoryDto,
  }) async {
    try {
      // 1. user컬렉션의 문서를 식별하기 위한 uid 세팅.
      final uid =
          await _guestRepository.getUid() ?? _authRepository.checkUser()?.uid;
      if (uid == null || uid == "") {
        throw Exception("uid not found");
      }

      // 2. 문서 생성 요청
      final newFlowHistory = await _flowHistoryRepository.createFlowHistory(
          uid: uid, flowHistoryDto: flowHistoryDto);

      talkerInfo("flowHistoryNotifier(createFlowHistory)",
          'created flow History : $newFlowHistory');
    } catch (e) {
      rethrow;
    }
  }
}
