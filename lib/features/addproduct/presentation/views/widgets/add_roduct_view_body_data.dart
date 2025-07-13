import 'dart:io';

import 'package:fashion_dashboard/core/entities/product_entity.dart';
import 'package:fashion_dashboard/core/widgets/custom_buttom.dart';
import 'package:fashion_dashboard/core/widgets/custom_text_feild.dart';
import 'package:fashion_dashboard/features/addproduct/presentation/manager/cubits/addproduct/addproduct_cubit.dart';
import 'package:fashion_dashboard/features/addproduct/presentation/views/widgets/image_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddproductViewBodyData extends StatefulWidget {
  const AddproductViewBodyData({super.key});

  @override
  State<AddproductViewBodyData> createState() => _AddproductViewBodyDataState();
}

class _AddproductViewBodyDataState extends State<AddproductViewBodyData> {
  @override
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String name, description;
  late double price;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextFormFeild(
            onSaved: (p0) {
              name = p0!;
            },
            hintText: 'Product Name',
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 20),
          CustomTextFormFeild(
            onSaved: (p0) {
              price = double.parse(p0!);
            },

            hintText: 'Product Price',
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          CustomTextFormFeild(
            onSaved: (p0) {
              description = p0!;
            },
            hintText: 'Product Description',
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 20),
          ImageFeild(
            onImageSelected: (image) {
              imageFile = image;
            },
          ),
          const SizedBox(height: 60),
          CustomButtom(
            text: 'Add Product',
            onPressed: () {
              if (imageFile != null) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<AddproductCubit>().addProduct(
                    ProductEntity(
                      docmentId: const Uuid().v4(),
                      name: name,
                      description: description,
                      price: price,
                      imageFile: imageFile!,
                    ),
                  );
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please Select Image')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
