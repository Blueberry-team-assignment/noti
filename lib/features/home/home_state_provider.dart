// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:noti_flutter/data/auth/auth_repository.dart';
// import 'package:noti_flutter/data/flow/flow_repository.dart';
// import 'package:noti_flutter/models/flow_model.dart';

// final homeStateProvider =
//     StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
//   final flowRepository = ref.watch(flowRepositoryProvider);
//   return HomeStateNotifier(flowRepository);
// });

// class HomeStateNotifier extends StateNotifier<HomeState> {
//   final FlowRepository _flowRepository;

//   HomeStateNotifier(
//     this._flowRepository,
//   ) : super(HomeState());

//   Future<void> loadFlowList({required String? uid}) async {
//     try {
//       if (uid == null || uid == "") {
//         throw Exception("uid not found yet");
//       }
//       state = state.copyWith(isLoading: true);

//       final flowList = await _flowRepository.getFlowList(uid: uid);

//       state = state.copyWith(flowList: flowList, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(isLoading: false);
//       rethrow;
//     }
//   }
// }

// class HomeState {
//   List<FlowModel>? flowList;
//   bool isLoading;

//   HomeState({
//     this.flowList,
//     this.isLoading = false,
//   });

//   HomeState copyWith({
//     List<FlowModel>? flowList,
//     bool? isLoading,
//   }) {
//     return HomeState(
//       flowList: flowList ?? this.flowList,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
// }
