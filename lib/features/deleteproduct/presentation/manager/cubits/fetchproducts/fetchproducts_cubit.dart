import 'package:bloc/bloc.dart';
import 'package:fashion_dashboard/core/entities/product_entity.dart';
import 'package:fashion_dashboard/core/models/product_model.dart';
import 'package:fashion_dashboard/core/repo/add_image/add_image_repo.dart';
import 'package:fashion_dashboard/core/repo/fetchproduct/fetch_product_repo.dart';
import 'package:meta/meta.dart';

part 'fetchproducts_state.dart';

class FetchproductsCubit extends Cubit<FetchproductsState> {
  final FetchProductRepo fetchProductRepo;
  final AddImageRepo addImageRepo;
  final List<ProductEntity> products = [];
  FetchproductsCubit(this.fetchProductRepo, this.addImageRepo)
    : super(FetchproductsInitial());

  Future<void> fetchProducts() async {
    emit(FetchproductsLoading());
    final result = await fetchProductRepo.fetchProduct();

    result.fold((l) => emit(FetchproductsError(l.message)), (res) {
      if (res is Iterable) {
        for (var element in res) {
          products.add(ProductModel.fromJson(element).toEntity());
        }
        emit(FetchproductsSuccess(products));
      } else {
        emit(FetchproductsError('Unexpected data format'));
      }
    });
  }

  Future<void> deleteProduct(String id) async {
    emit(FetchproductsLoading());
    final result = await fetchProductRepo.deleteProduct(id);
    final result2 = await addImageRepo.deleteImage(id);

    result.fold((l) => emit(FetchproductsError(l.message)), (res) {
      result2.fold((l) => emit(FetchproductsError(l.message)), (res) {
        products.removeWhere((element) => element.docmentId == id);
        emit(FetchproductsSuccess(products));
      });
    });
  }
}
