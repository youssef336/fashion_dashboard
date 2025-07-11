import 'package:fashion_dashboard/features/addproduct/presentation/views/widgets/addproduct_view_body.dart';
import 'package:flutter/material.dart';

class AddproductView extends StatelessWidget {
  const AddproductView({super.key});
  static const routeName = '/addproduct';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AddproductViewBody());
  }
}
