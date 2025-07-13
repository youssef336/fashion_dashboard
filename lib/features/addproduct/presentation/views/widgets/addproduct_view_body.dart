
import 'package:fashion_dashboard/features/addproduct/presentation/views/widgets/add_roduct_view_body_data.dart';
import 'package:flutter/material.dart';

class AddproductViewBody extends StatelessWidget {
  const AddproductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            const AddproductViewBodyData(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
