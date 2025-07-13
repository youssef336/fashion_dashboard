import 'dart:io';

import 'package:fashion_dashboard/core/widgets/custom_buttom.dart';
import 'package:fashion_dashboard/core/widgets/custom_text_feild.dart';
import 'package:fashion_dashboard/features/addproduct/presentation/manager/cubits/addproduct/addproduct_cubit.dart';
import 'package:fashion_dashboard/features/addproduct/presentation/views/widgets/add_roduct_view_body_data.dart';
import 'package:fashion_dashboard/features/addproduct/presentation/views/widgets/image_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

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
