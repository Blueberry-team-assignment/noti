import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/flow/flow_repository.dart';
import 'package:noti_flutter/models/flow_model.dart';

final flowTimerProvider =
    StateNotifierProvider<FlowTimerNotifier, FlowState>((ref) {
  final flowRepository = ref.watch(flowRepositoryProvider);
  return FlowTimerNotifier(flowRepository);
});

class FlowTimerNotifier extends StateNotifier<FlowState> {
  final FlowRepository _flowRepository;

  FlowTimerNotifier(
    this._flowRepository,
  ) : super(FlowState());

  void setFlowInfo(FlowModel flow) {
    state = state.copyWith(flow: flow);
  }
}

class FlowState {
  FlowModel? flow;
  bool isLoading;

  FlowState({
    this.flow,
    this.isLoading = false,
  });

  FlowState copyWith({
    FlowModel? flow,
    bool? isLoading,
  }) {
    return FlowState(
      flow: flow ?? this.flow,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
