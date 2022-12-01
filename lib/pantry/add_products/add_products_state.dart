part of 'add_products_bloc.dart';

abstract class AddProductsState extends Equatable {
  const AddProductsState();
  
  @override
  List<Object> get props => [];
}

class AddProductsInitial extends AddProductsState {}

class LoadingState extends AddProductsState {}

class AddProductSuccess extends AddProductsState {}

class AddProductError extends AddProductsState {}

class UpdateProductSuccess extends AddProductsState {}

class UpdateProductError extends AddProductsState {}

class DeleteProductSuccess extends AddProductsState {}

class DeleteProductError extends AddProductsState {}
