// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:fashion_dashboard/core/entities/product_entity.dart';
import 'package:fashion_dashboard/core/repo/addProduct/add_product_repo.dart';
import 'package:fashion_dashboard/core/repo/add_image/add_image_repo.dart';
import 'package:meta/meta.dart';

part 'addproduct_state.dart';

class AddproductCubit extends Cubit<AddproductState> {
  final AddProductRepo addProductRepo;
  final AddImageRepo addImageRepo;
  AddproductCubit(this.addProductRepo, this.addImageRepo)
    : super(AddproductInitial());

  Future<void> addProduct(ProductEntity ProductEntity) async {
    emit(AddproductLoading());
    final result = await addImageRepo.addImage(ProductEntity.imageFile);
    result.fold((l) => emit(AddproductError(l.message)), (Url) async {
      ProductEntity.image = Url;
      final result = await addProductRepo.addProduct(ProductEntity);
      result.fold(
        (l) => emit(AddproductError(l.message)),
        (r) => emit(AddproductSuccess(addproductEntity: ProductEntity)),
      );
    });
  }
}
