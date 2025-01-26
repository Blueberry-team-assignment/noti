import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/flow/flow_repository.dart';
import 'package:noti_flutter/dto/flow_dto.dart';

final registerFlowProvider =
    StateNotifierProvider<RegisterFlowNotifier, RegisterFlowState>((ref) {
  final flowRepository = ref.watch(flowRepositoryProvider);
  return RegisterFlowNotifier(flowRepository);
});

class RegisterFlowNotifier extends StateNotifier<RegisterFlowState> {
  final FlowRepository _flowRepository;

  RegisterFlowNotifier(
    this._flowRepository,
  ) : super(RegisterFlowState());

  Future<void> createFlow({
    required String? uid,
    required FlowDto flowDto,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      if (uid == null) {
        throw Exception("uid not found");
      }

      final createdFlow =
          await _flowRepository.createFlow(uid: uid, flowDto: flowDto);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

class RegisterFlowState {
  FlowDto? flowDto;
  bool isLoading;

  RegisterFlowState({
    this.flowDto,
    this.isLoading = false,
  });

  RegisterFlowState copyWith({
    FlowDto? flowDto,
    bool? isLoading,
  }) {
    return RegisterFlowState(
      flowDto: flowDto ?? this.flowDto,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
