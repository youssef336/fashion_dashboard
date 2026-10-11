<h1 align="center">Fashion Dashboard</h1>

<p align="center">
  <b>Admin app for the Fashion store — manage products and push notifications to the manager.</b><br/>
  Flutter · Firebase (Auth, Firestore, Cloud Messaging, Cloud Functions) · Supabase Storage
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/Supabase-3ECF8E?style=flat-square&logo=supabase&logoColor=white" alt="Supabase"/>
  <img src="https://img.shields.io/badge/Node.js-339933?style=flat-square&logo=nodedotjs&logoColor=white" alt="Node.js"/>
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-3DDC84?style=flat-square&logo=android&logoColor=white" alt="Platform"/>
</p>

---

## 📖 About

The admin side of a two-app e-commerce project — its storefront is **[fashion_app](https://github.com/youssef336/fashion_app)**. It was built while following a Flutter + Firebase e-commerce course and goes a step further into backend work: images in **Supabase Storage**, **push notifications** with Firebase Cloud Messaging and `flutter_local_notifications`, a **Cloud Function** that notifies the manager when a notification document is created, and **Firestore security rules**.

**Concepts practised:** Clean Architecture, Bloc/Cubit, `get_it` dependency injection, `dartz` error handling, FCM token management, Cloud Functions, and storage migrations with Node.js scripts.

## ✨ Features

- 🔐 **Admin login** with Firebase Auth — signed-in admins skip straight to the dashboard
- ➕ **Add product** — name, price, description and an image picked with `image_picker`, uploaded to Supabase Storage and saved to Firestore
- 🗑 **Manage products** — list the catalog and delete a product together with its stored image
- 🔔 **Notifications** — compose an offer (English / Arabic description, coupon code, image) and send it as a push notification
- 📲 **FCM setup** — saves the manager's device token to `managers/admin` and shows foreground messages as local notifications
- ☁️ **Cloud Function** `notifyManagerOnNewNotification` — pushes to the manager whenever a document is added to `notifications`
- 🛡 **Firestore rules** — public catalog, token document writable only by its signed-in owner, everything else authenticated
- 🧰 **Node.js scripts** — `sendFcm.js` and storage / image-URL migration scripts in `scripts/`

## 🛠 Tech stack

| Concern | Choice |
|---|---|
| Framework | Flutter, Dart 3 |
| State management | `bloc` / `flutter_bloc` |
| Architecture | Feature-first Clean Architecture, repository pattern, `get_it`, `dartz`, `equatable` |
| Backend | Firebase Auth, Cloud Firestore |
| Storage | Supabase Storage (`supabase_flutter`) |
| Messaging | `firebase_messaging`, `flutter_local_notifications`, `googleapis_auth`, `http` |
| Server side | Firebase Cloud Functions (Node 22), `firebase-admin` |
| UI | `skeletonizer`, `modal_progress_hud_nsn` |

## 🏗 Project structure

```
lib/
├── core/
│   ├── services/        # Firebase auth, Firestore, Supabase storage, FCM, push, prefs, get_it
│   ├── repo/            # products, images, customer access flag
│   └── entities/ models/ errors/ helper_functions/ utils/
└── features/
    ├── auth/            # admin login
    ├── addproduct/
    ├── deleteproduct/
    └── notification/    # compose + send offers
functions/index.js       # Cloud Function: notify manager on new notification
scripts/                 # Supabase storage + Firestore image-URL migrations
firestore.rules
```

## 🚀 Getting started

**Prerequisites:** Flutter SDK (Dart `^3.8`), a Firebase project (Auth, Firestore, Cloud Messaging) and a Supabase project with a storage bucket.

```bash
git clone https://github.com/youssef336/fashion_dashboard.git
cd fashion_dashboard
flutter pub get
flutter run
```

**Configuration**
1. Run `flutterfire configure` with the same Firebase project as the storefront, then deploy the rules and function:
   ```bash
   firebase deploy --only firestore:rules
   cd functions && npm install && npm run deploy
   ```
2. Create `lib/secret_conatant.dart` (not committed) with your own values:
   ```dart
   const KsupabaseUrl = 'https://<project>.supabase.co';
   const KsupabaseKey = '<supabase-anon-key>';
   const KsupabaseBucket = '<bucket-name>';
   const SecretKey = '<fcm-server-key>';
   ```
3. `lib/features/home/` is committed as a submodule pointer without its source, so you will need to provide a `HomeView` (route to the add / delete product and notification pages) before the app compiles.

## 👤 Author

**Youssef Belal Zakaria** · [GitHub @youssef336](https://github.com/youssef336)

⭐ If you like this project, give it a star!
