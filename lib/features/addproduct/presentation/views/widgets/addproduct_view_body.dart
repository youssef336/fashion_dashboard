import 'package:fashion_dashboard/core/widgets/custom_buttom.dart';
import 'package:fashion_dashboard/core/widgets/custom_text_feild.dart';
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
            const CustomTextFormFeild(
              hintText: 'Product Name',
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            const CustomTextFormFeild(
              hintText: 'Product Price',
              textInputType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const CustomTextFormFeild(
              hintText: 'Product Description',
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            const CustomTextFormFeild(
              hintText: 'Product Image',
              maxLines: 5,
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 60),
            const CustomButtom(text: 'Add Product'),
          ],
        ),
      ),
    );
  }
}
