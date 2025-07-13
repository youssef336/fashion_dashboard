part of 'products_cubit.dart';

@immutable
abstract class FetchproductsState {}

class FetchproductsInitial extends FetchproductsState {}

class FetchproductsLoading extends FetchproductsState {}

class FetchproductsSuccess extends FetchproductsState {
  final List<ProductEntity> products;
  FetchproductsSuccess(this.products);
}

class FetchproductsError extends FetchproductsState {
  final String message;
  FetchproductsError(this.message);
}
