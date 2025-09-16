// ignore_for_file: camel_case_types

import 'package:fashion_dashboard/core/helper_functions/on_generate_routes.dart';
import 'package:fashion_dashboard/core/services/firebase_auth_service.dart';
import 'package:fashion_dashboard/core/services/get_it_service.dart';
import 'package:fashion_dashboard/core/services/notification_service.dart';
import 'package:fashion_dashboard/core/services/shared_preferences_service.dart';

import 'package:fashion_dashboard/features/auth/presentation/views/login_view.dart';
import 'package:fashion_dashboard/features/home/presentation/views/home_view.dart';
import 'package:fashion_dashboard/firebase_options.dart';
import 'package:fashion_dashboard/secret_conatant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  NotificationService.setupHandlers();
  await Supabase.initialize(url: KsupabaseUrl, anonKey: KsupabaseKey);
  setupGetIt();
  await Prefs.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const fashion_dashboard());
}

class fashion_dashboard extends StatelessWidget {
  const fashion_dashboard({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: isUserLoggedIn() ? HomeView.routeName : LoginView.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
