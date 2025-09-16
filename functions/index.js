const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// Trigger when a new notification doc is created
exports.notifyManagerOnNewNotification = functions.firestore
  .document("notifications/{notifId}")
  .onCreate(async (snap, context) => {
    const notif = snap.data();

    // Get manager token from Firestore (doc ID = "admin")
    const managerDoc = await admin.firestore().collection("managers").doc("admin").get();
    const token = managerDoc.data()?.fcmToken;

    if (!token) {
      console.log("❌ No manager token found");
      return null;
    }

    const message = {
      notification: {
        title: notif.title || "New Notification",
        body: notif.body || "Check the dashboard",
      },
      token: token,
    };

    try {
      const response = await admin.messaging().send(message);
      console.log("✅ Push sent to manager:", response);
    } catch (error) {
      console.error("❌ Error sending push:", error);
    }
  });
