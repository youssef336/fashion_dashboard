import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_dashboard/core/services/main/database_service.dart';

class FirebaseDatabaseServer implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  }) async {
    if (documentId != null) {
      return await firestore.collection(path).doc(documentId).get();
    } else {
      var result = await firestore.collection(path).get();
      return result.docs.map((e) => e.data()).toList();
    }
  }

  @override
  Future<void> deleteData({
    required String path,
    required String documentId,
  }) async {
    await firestore.collection(path).doc(documentId).delete();
  }
}
