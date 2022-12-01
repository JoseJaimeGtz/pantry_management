part of 'add_products_bloc.dart';

abstract class AddProductsEvent extends Equatable {
  const AddProductsEvent();

  @override
  List<Object> get props => [];
}

class AddToListEvent extends AddProductsEvent {
  final String product_name;
  final int quantity;
  final DateTime expiration_date;

  AddToListEvent({required this.product_name, required this.quantity, required this.expiration_date});  
}

class UpdateProductEvent extends AddProductsEvent {
  final dynamic updatedIngredient;
  final dynamic deletedIngredient;
  final int id;

  UpdateProductEvent({required this.updatedIngredient, required this.id, required this.deletedIngredient});

}

class DeleteProductEvent extends AddProductsEvent {
  final dynamic deletedIngredient;
  final int id;

  DeleteProductEvent({required this.deletedIngredient, required this.id});
}