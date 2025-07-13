import 'package:fashion_dashboard/core/helper_functions/build_error_bar.dart';
import 'package:fashion_dashboard/core/repo/addProduct/add_product_repo.dart';
import 'package:fashion_dashboard/core/repo/add_image/add_image_repo.dart';
import 'package:fashion_dashboard/core/services/get_it_service.dart';
import 'package:fashion_dashboard/core/widgets/custom_modal_progress_hub.dart';
import 'package:fashion_dashboard/features/addproduct/presentation/manager/cubits/addproduct/addproduct_cubit.dart';
import 'package:fashion_dashboard/features/addproduct/presentation/views/widgets/addproduct_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddproductView extends StatelessWidget {
  const AddproductView({super.key});
  static const routeName = '/addproduct';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AddproductCubit(getIt<AddProductRepo>(), getIt<AddImageRepo>()),
        child: const AddproductViewBodyBlocListener(),
      ),
    );
  }
}

class AddproductViewBodyBlocListener extends StatelessWidget {
  const AddproductViewBodyBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddproductCubit, AddproductState>(
      listener: (context, state) {
        if (state is AddproductSuccess) {
          showErrorBar(context, "Product Added Successfully");
        } else if (state is AddproductError) {
          showErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomModalProgressHUD(
          inAsyncCall: state is AddproductLoading,
          child: const AddproductViewBody(),
        );
      },
    );
  }
}
