import 'package:fashion_dashboard/core/helper_functions/build_error_bar.dart';
import 'package:fashion_dashboard/features/deleteproduct/presentation/manager/cubits/fetchproducts/products_cubit.dart';
import 'package:fashion_dashboard/features/deleteproduct/presentation/views/widgets/delete_product_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteProductViewBodyBlocCunsumer extends StatelessWidget {
  const DeleteProductViewBodyBlocCunsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<productsCubit, FetchproductsState>(
      listener: (context, state) {
        if (state is FetchproductsError) {
          showErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is FetchproductsSuccess) {
          return DeleteProductViewBody(products: state.products);
        } else if (state is FetchproductsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return const Center(
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
