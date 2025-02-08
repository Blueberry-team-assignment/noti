import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/flow/flow_history_repository.dart';
import 'package:noti_flutter/data/local_storage/guest_repository.dart';
import 'package:noti_flutter/dto/flow_history_dto.dart';
import 'package:noti_flutter/models/flow_history_model.dart';
import 'package:noti_flutter/common/utils/talker.dart';

/*  플로우 기록을 관리하기 위한 프로바이더.
    1. flowTimerScreen에서 사용자가 "기록을 저장하고 종료하기"를 탭할 시 완료한 플로우 기록을 db에 저장합니다.
    2. myPageScreen에서 사용자가 저장한 플로우 기록을 목록으로 제공합니다.
 */

final flowHistoryProvider = StateNotifierProvider.autoDispose<
    FlowHistoryNotifier, AsyncValue<List<FlowHistoryModel>>>((ref) {
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
  ) : super(const AsyncValue.loading()) {
    fetchFlowHistories();
  }

  Future<void> fetchFlowHistories() async {
    try {
      // 1. user컬렉션의 문서를 식별하기 위한 uid를 세팅합니다.
      final uid =
          await _guestRepository.getUid() ?? _authRepository.checkUser()?.uid;
      if (uid == null || uid == "") {
        throw Exception("uid not found");
      }

      // 2. 서버에 데이터를 요청합니다.
      final flowHistories =
          await _flowHistoryRepository.getFlowHistories(uid: uid);

      // 3. 반환된 데이터를 화면에 표시하기 위해 상태에 저장합니다.
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
      // 1. user컬렉션의 문서를 식별하기 위한 uid를 세팅합니다.
      final uid =
          await _guestRepository.getUid() ?? _authRepository.checkUser()?.uid;
      if (uid == null || uid == "") {
        throw Exception("uid not found");
      }

      // 2. 서버에 문서 생성을 요청합니다.
      final newFlowHistory = await _flowHistoryRepository.createFlowHistory(
          uid: uid, flowHistoryDto: flowHistoryDto);

      talkerInfo("flowHistoryNotifier(createFlowHistory)",
          'created flow History : $newFlowHistory');
    } catch (e) {
      rethrow;
    }
  }
}
