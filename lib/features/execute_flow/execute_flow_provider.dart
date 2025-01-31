import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/data/auth/auth_repository.dart';
import 'package:noti_flutter/data/flow/flow_repository.dart';
import 'package:noti_flutter/models/flow_model.dart';

final executeFlowProvider =
    StateNotifierProvider<ExecuteFlowNotifier, FlowState>((ref) {
  final flowRepository = ref.watch(flowRepositoryProvider);
  return ExecuteFlowNotifier(flowRepository);
});

class ExecuteFlowNotifier extends StateNotifier<FlowState> {
  final FlowRepository _flowRepository;

  ExecuteFlowNotifier(
    this._flowRepository,
  ) : super(FlowState());
}

class FlowState {
  List<FlowModel>? flow;
  bool isLoading;

  FlowState({
    this.flow,
    this.isLoading = false,
  });

  FlowState copyWith({
    List<FlowModel>? flow,
    bool? isLoading,
  }) {
    return FlowState(
      flow: flow ?? this.flow,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
