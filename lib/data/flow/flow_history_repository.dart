import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/dto/flow_history_dto.dart';
import 'package:noti_flutter/models/flow_history_model.dart';
import 'package:noti_flutter/common/utils/talker.dart';

/*  플로우를 완료한 기록을 관리하기 위한 레포지토리.
    사용자의 uid를 통해 fireStore의 user컬렉션의 위치를 식별하여, 플로우 기록의 조회와 저장 기능을 제공합니다.
*/

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
          .collection('flow_histories')
          .orderBy('date', descending: true);

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
      // 1. 'flow_histories'라는 이름의 콜렉션 조회하고, 없다면 이 이름으로 문서를 생성합니다.
      final flowHistoryRef = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('flow_histories');

      // 2. 컬렉션에 문서를 추가합니다.
      final newFlowHistoryRef =
          await flowHistoryRef.add(flowHistoryDto.toJson());

      // 3. 추가한 문서를 다시 조회합니다. (반환하지 않을거면 안해도 됨)
      final newFlowHistory = await newFlowHistoryRef.get();
      final data = newFlowHistory.data();
      if (data == null) throw Exception("created flow history not found");
      // 4. 문서 생성 시 자동 생성되는 id값을 문서의 id로 넣어줍니다.
      data["id"] = newFlowHistory.id;

      talkerInfo("FlowHistoryRepository(createFlowHistory)",
          "success to create new flow history : $data");

      // 5. json형식의 데이터를 클라이언트 단에서 사용할 수 있도록 정의해둔 모델로 변환해서 반환합니다.
      return FlowHistoryModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
