import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_dashboard/secret_conatant.dart';
import 'package:http/http.dart' as http;

class PushService {
  // Put your server key here (get from Firebase console → Cloud Messaging)
  // Warning: not secure to have in client-side code.
  static const String _serverKey = SecretKey;

  static Future<String?> getManagerToken() async {
    final doc = await FirebaseFirestore.instance
        .collection('managers')
        .doc('admin')
        .get();
    if (doc.exists) {
      return doc.data()?['fcmToken'];
    }
    return null;
  }

  static Future<void> sendNotification(String title, String body) async {
    final token = await getManagerToken();
    if (token == null) {
      print("No manager token found");
      return;
    }

    final url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "key=$_serverKey",
    };

    final payload = {
      "to": token,
      "notification": {"title": title, "body": body},
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(payload),
    );
    print("Push response: ${response.statusCode} ${response.body}");
  }
}
