import 'package:fashion_dashboard/features/addproduct/presentation/views/addproduct_view.dart';
import 'package:fashion_dashboard/features/auth/presentation/views/login_view.dart';
import 'package:fashion_dashboard/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case AddproductView.routeName:
      return MaterialPageRoute(builder: (_) => const AddproductView());
    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('404 Not Found'))),
      );
  }
}
