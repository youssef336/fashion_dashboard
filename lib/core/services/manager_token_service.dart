import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ManagerTokenService {
  static Future<void> saveManagerToken(String managerId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      debugPrint('Skip manager token save: no authenticated Firebase user.');
      return;
    }

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      try {
        await FirebaseFirestore.instance
            .collection('managers')
            .doc(managerId)
            .set({
              'fcmToken': token,
              'updatedAt': FieldValue.serverTimestamp(),
              'uid': currentUser.uid,
            }, SetOptions(merge: true));
        debugPrint('Manager token saved: $token');
      } on FirebaseException catch (e) {
        debugPrint(
          'Manager token save failed (${e.code}): ${e.message ?? 'unknown error'}',
        );
      } catch (e) {
        debugPrint('Manager token save failed: $e');
      }
    }
  }
}
