// ignore_for_file: must_be_immutable

part of 'addproduct_cubit.dart';

@immutable
abstract class AddproductState {}

class AddproductInitial extends AddproductState {}

class AddproductLoading extends AddproductState {}

class AddproductSuccess extends AddproductState {
  ProductEntity addproductEntity;
  AddproductSuccess({required this.addproductEntity});
}

class AddproductError extends AddproductState {
  final String message;
  AddproductError(this.message);
}
