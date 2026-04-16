const admin = require("firebase-admin");
const serviceAccount = require("./fashion-app-7bd03-89cb5b0fc055.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();
const messaging = admin.messaging();

async function sendNotification(token, title, body, imageUrl) {
  const message = {
    token,
    notification: {
      title,
      body,
      image: imageUrl || undefined,
    },
  };

  try {
    const response = await messaging.send(message);
    console.log("✅ Notification sent:", response);
  } catch (err) {
    console.error("❌ Error sending notification:", err);
  }
}

async function main() {
  // Get latest notification from Firestore
  const notifSnap = await db.collection("notifications")
    .orderBy("date", "desc")
    .limit(1)
    .get();

  if (notifSnap.empty) {
    console.error("❌ No notifications found");
    return;
  }

  const notif = notifSnap.docs[0].data();
  const managerDoc = await db.collection("managers").doc("admin").get();
  const token = managerDoc.data().fcmToken;

  console.log("📲 Sending notification:", notif.descriptioninEnglish);

  await sendNotification(
    token,
    notif.descriptioninEnglish,
    notif.descriptionInArabic,
    notif.imageUrl // Make sure you upload and save image URL in Firestore
  );
}

main();
