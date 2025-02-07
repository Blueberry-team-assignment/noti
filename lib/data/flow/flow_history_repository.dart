import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/dto/flow_history_dto.dart';
import 'package:noti_flutter/models/flow_history_model.dart';
import 'package:noti_flutter/talker.dart';

final flowHistoryRepositoryProvider = Provider<FlowHistoryRepository>((ref) {
  final firebaseFireStore = FirebaseFirestore.instance;
  return FlowHistoryRepositoryImpl(firebaseFireStore);
});

abstract class FlowHistoryRepository {
  Future<List<FlowHistoryModel>> getFlowHistories({
    required String uid,
  });

  Future<FlowHistoryModel> createFlowHistory({
    required String uid,
    required FlowHistoryDto flowHistoryDto,
  });
}

class FlowHistoryRepositoryImpl implements FlowHistoryRepository {
  final FirebaseFirestore _firebaseFirestore;

  FlowHistoryRepositoryImpl(
    this._firebaseFirestore,
  );

  // 플로우 실행한 기록을 조회하는 메서드
  @override
  Future<List<FlowHistoryModel>> getFlowHistories({
    required String uid,
  }) async {
    try {
      final flowHistoriesRef = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('flow_histories');

      final flowHistories = await flowHistoriesRef.get();
      if (flowHistories.docs.isEmpty) {
        return [];
      }
      talkerInfo(
          "FlowHistoryRepository(getFlowHistories)",
          "success to fetch flow histories : ${flowHistories.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return FlowHistoryModel.fromJson(data);
          }).toList()}");

      return flowHistories.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return FlowHistoryModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  // 플로우 실행한 기록을 저장하는 메서드
  @override
  Future<FlowHistoryModel> createFlowHistory({
    required String uid,
    required FlowHistoryDto flowHistoryDto,
  }) async {
    try {
      // 1. 'flow_histories'라는 이름의 콜렉션 조회. 없다면 생성.
      final flowHistoryRef = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('flow_histories');

      // 2. 컬렉션에 문서를 추가.
      final newFlowHistoryRef =
          await flowHistoryRef.add(flowHistoryDto.toJson());

      // 3. 추가한 문서를 다시 조회. (반환하지 않을거면 안해도 됨)
      final newFlowHistory = await newFlowHistoryRef.get();
      final data = newFlowHistory.data();
      if (data == null) throw Exception("created flow history not found");
      // 4. 문서 생성 시 자동 생성되는 id값을 문서의 id로 넣어줌.
      data["id"] = newFlowHistory.id;

      talkerInfo("FlowHistoryRepository(createFlowHistory)",
          "success to create new flow history : $data");

      // 5. json형식의 데이터를 클라이언트 단에서 사용할 수 있도록 정의해둔 모델로 변환해서 반환.
      return FlowHistoryModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
