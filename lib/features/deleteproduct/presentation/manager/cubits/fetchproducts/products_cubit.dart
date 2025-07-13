// ignore_for_file: camel_case_types

import 'package:bloc/bloc.dart';

import 'package:fashion_dashboard/core/entities/product_entity.dart';
import 'package:fashion_dashboard/core/models/product_model.dart';
import 'package:fashion_dashboard/core/repo/add_image/add_image_repo.dart';
import 'package:fashion_dashboard/core/repo/fetchproduct/fetch_product_repo.dart';
import 'package:flutter/foundation.dart';

part 'products_state.dart';

class productsCubit extends Cubit<FetchproductsState> {
  final FetchProductRepo fetchProductRepo;
  final AddImageRepo addImageRepo;
  final List<ProductEntity> products = [];
  productsCubit(this.fetchProductRepo, this.addImageRepo)
    : super(FetchproductsInitial());

  Future<void> fetchProducts() async {
    emit(FetchproductsLoading());
    final result = await fetchProductRepo.fetchProduct();

    result.fold((l) => emit(FetchproductsError(l.message)), (res) {
      for (var element in res) {
        products.add(ProductModel.fromJson(element).toEntity());
      }
      emit(FetchproductsSuccess(products));
    });
  }

  Future<void> deleteProduct(String id) async {
    emit(FetchproductsLoading());

    // Find the product to get its image URL
    final product = products.firstWhere((p) => p.docmentId == id);

    // Extract the file path from the image URL
    // The URL is in format: https://<project-ref>.supabase.co/storage/v1/object/public/<bucket-name>/<file-path>
    if (product.image != null && product.image!.isNotEmpty) {
      try {
        // Parse the URL to get the path
        final uri = Uri.parse(product.image!);
        // The path will be everything after '/object/public/<bucket-name>/'
        final pathSegments = uri.pathSegments;
        final bucketIndex = pathSegments.indexOf('public') + 1;
        if (bucketIndex > 0 && pathSegments.length > bucketIndex + 1) {
          final filePath = pathSegments.sublist(bucketIndex + 1).join('/');
          // Delete the image from storage
          final deleteResult = await addImageRepo.deleteImage(filePath);
          if (deleteResult.isLeft()) {
            emit(FetchproductsError('Failed to delete image'));
            return;
          }
        }
      } catch (e) {
        // If there's an error deleting the image, we'll still try to delete the product
        // but emit a warning
        debugPrint('Error deleting image: $e');
      }
    }

    // Delete the product from the database
    final result = await fetchProductRepo.deleteProduct(id);

    result.fold((l) => emit(FetchproductsError(l.message)), (r) {
      // Remove the product from the local list
      products.removeWhere((element) => element.docmentId == id);
      emit(FetchproductsSuccess(products));
    });
  }
}
