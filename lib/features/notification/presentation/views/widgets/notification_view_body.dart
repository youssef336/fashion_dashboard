import 'dart:io';

import 'package:fashion_dashboard/core/widgets/custom_buttom.dart';
import 'package:fashion_dashboard/core/widgets/custom_text_feild.dart';
import 'package:fashion_dashboard/features/addproduct/presentation/views/widgets/image_feild.dart';
import 'package:fashion_dashboard/features/notification/domain/entities/notification_entity.dart';
import 'package:fashion_dashboard/features/notification/presentation/manager/cubits/notification/notification_cubit.dart';
import 'package:fashion_dashboard/features/notification/presentation/manager/cubits/notification/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key});

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  final _formKey = GlobalKey<FormState>();
  String? _description;
  String? descriptioninArabic;
  String? code;
  double? discount;

  File? _image;
  final DateTime _date = DateTime.now();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  CustomTextFormFeild(
                    hintText: "Description in English",
                    textInputType: TextInputType.text,
                    onSaved: (value) => _description = value,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormFeild(
                    hintText: "Description in Arabic",
                    textInputType: TextInputType.text,
                    onSaved: (value) => descriptioninArabic = value,
                  ),
                  const SizedBox(height: 16),

                  CustomTextFormFeild(
                    hintText: "Code",
                    textInputType: TextInputType.text,
                    onSaved: (value) => code = value,
                  ),
                  const SizedBox(height: 16),
                  ImageFeild(
                    onImageSelected: (value) {
                      setState(() {
                        _image = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (state is NotificationSuccess)
                    const Text('Notification sent successfully!'),
                  if (state is NotificationFailure)
                    Text('Error: ${state.message}'),
                  CustomButtom(
                    text: 'Send Notification',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (_image != null) {
                          context.read<NotificationCubit>().addNotification(
                            NotificationEntity(
                              code: code!,

                              descriptionInArabic: descriptioninArabic!,
                              descriptioninEnglish: _description!,
                              image: _image!,
                              date: _date,
                            ),
                          );
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
