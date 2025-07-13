import 'package:fashion_dashboard/core/repo/add_image/add_image_repo.dart';
import 'package:fashion_dashboard/core/repo/fetchproduct/fetch_product_repo.dart';
import 'package:fashion_dashboard/core/services/get_it_service.dart';
import 'package:fashion_dashboard/features/deleteproduct/presentation/manager/cubits/fetchproducts/products_cubit.dart';
import 'package:fashion_dashboard/features/deleteproduct/presentation/views/widgets/delete_product_view_body_bloc_cunsumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteProductView extends StatefulWidget {
  const DeleteProductView({super.key});
  static const routeName = '/delete-product';

  @override
  State<DeleteProductView> createState() => _DeleteProductViewState();
}

class _DeleteProductViewState extends State<DeleteProductView> {
  late final productsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = productsCubit(getIt<FetchProductRepo>(), getIt<AddImageRepo>());

    _cubit.fetchProducts();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: BlocProvider.value(
        value: _cubit,
        child: const DeleteProductViewBodyBlocCunsumer(),
      ),
    );
  }
}
