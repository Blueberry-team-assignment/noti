import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/flow/flow_repository.dart';
import 'package:noti_flutter/models/flow_model.dart';

final flowScreenProvider =
    StateNotifierProvider<FlowScreenNotifier, FlowState>((ref) {
  final flowRepository = ref.watch(flowRepositoryProvider);
  return FlowScreenNotifier(flowRepository);
});

class FlowScreenNotifier extends StateNotifier<FlowState> {
  final FlowRepository _flowRepository;

  FlowScreenNotifier(
    this._flowRepository,
  ) : super(FlowState());

  void setFlowInfo(FlowModel flow) {
    state = state.copyWith(flow: flow);
  }
}

class FlowState {
  FlowModel? flow;
  Duration elapsedTime;
  bool isLoading;

  FlowState({
    this.flow,
    this.elapsedTime = Duration.zero,
    this.isLoading = false,
  });

  FlowState copyWith({
    FlowModel? flow,
    Duration? elapsedTime,
    bool? isLoading,
  }) {
    return FlowState(
      flow: flow ?? this.flow,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
