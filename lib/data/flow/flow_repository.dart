import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noti_flutter/dto/flow_dto.dart';
import 'package:noti_flutter/models/flow_model.dart';
import 'package:noti_flutter/common/utils/talker.dart';

/*  플로우를 실행하기 위한 데이터를 관리하는 레포지토리.
    사용자의 uid를 통해 fireStore의 user컬렉션의 위치를 식별하여 플로우 데이터의 CRUD를 처리합니다.
 */

final flowRepositoryProvider = Provider<FlowRepository>((ref) {
  final firebaseFireStore = FirebaseFirestore.instance;
  return FlowRepositoryImpl(firebaseFireStore);
});

abstract class FlowRepository {
  Future<List<FlowModel>> getFlowList({
    required String uid,
  });

  Future<void> updateFlow({
    required String uid,
    required FlowDto flowDto,
  });

  Future<FlowModel> createFlow({
    required String uid,
    required FlowDto flowDto,
  });
  Future<void> deleteFlow({
    required String uid,
    required String flowId,
  });
}

class FlowRepositoryImpl implements FlowRepository {
  final FirebaseFirestore _firebaseFirestore;

  FlowRepositoryImpl(
    this._firebaseFirestore,
  );

  @override
  Future<List<FlowModel>> getFlowList({
    required String uid,
  }) async {
    try {
      final flowRef =
          _firebaseFirestore.collection('users').doc(uid).collection('flows');

      final flowList = await flowRef.get();
      if (flowList.docs.isEmpty) {
        return [];
      }
      talkerInfo(
          "flowRepository(getFlowList)",
          "fetched flow List : ${flowList.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return FlowModel.fromJson(data);
          }).toList()}");

      return flowList.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return FlowModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<FlowModel> createFlow({
    required String uid,
    required FlowDto flowDto,
  }) async {
    try {
      final flowRef =
          _firebaseFirestore.collection('users').doc(uid).collection('flows');

      final newFlowRef = await flowRef.add(flowDto.toJson());

      final newFlow = await newFlowRef.get();

      final data = newFlow.data();
      if (data == null) throw Exception("created flow not found");
      data["id"] = newFlow.id;

      talkerInfo("flowRepository(createFlow)", "create flow : $data");

      return FlowModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateFlow({
    required String uid,
    required FlowDto flowDto,
  }) async {
    try {
      final flowRef = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('flows')
          .doc(flowDto.id);

      await flowRef.update(flowDto.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteFlow({
    required String uid,
    required String flowId,
  }) async {
    try {
      final flowRef = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('flows')
          .doc(flowId);

      await flowRef.delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
