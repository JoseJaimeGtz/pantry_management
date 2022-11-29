import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'add_products_event.dart';
part 'add_products_state.dart';

class AddProductsBloc extends Bloc<AddProductsEvent, AddProductsState> {
  AddProductsBloc() : super(AddProductsInitial()) {
    on<AddToListEvent>(_addProductToList);
    on<ShowProductsEvent>(_showUsersProducts);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  String userData() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
  }

  dynamic responseFromDatabase(uid) async {
    final DocumentSnapshot res = await FirebaseFirestore.instance.collection('users_pantry').doc(uid).get();
    return res;
  }

  FutureOr<void> _addProductToList(event, emit) async {
    emit(LoadingState());
    String uid = userData();
    print("Adding product to user: ${uid}");
    final response = await responseFromDatabase(uid);
    print(response.data());
    //bool alreadyAdded = false;
    print(response['ingredients']);
    try{
      dynamic addIngredient = {
        "product_name": event.product_name,
        "quantity": event.quantity,
        "expiration_date": event.expiration_date
      }; 

      db.collection('users_pantry').doc(uid).update({'ingredients': FieldValue.arrayUnion([addIngredient])});
      emit(AddProductSuccess());

    }catch(e){
      print(e);
      emit(AddProductError());
    }
  }

  FutureOr<void> _showUsersProducts(event, emit) async{
    // regresar los ingredientes 
  }
  // eliminar los productos

  // actualizar un producto en específico
}
