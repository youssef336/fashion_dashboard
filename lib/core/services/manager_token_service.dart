import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerTokenService {
  static Future<void> saveManagerToken(String managerId) async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await FirebaseFirestore.instance
          .collection('managers')
          .doc(managerId)
          .set({
            'fcmToken': token,
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
      print("✅ Manager token saved: $token");
    }
  }
}
