part of 'recipes_bloc.dart';

abstract class RecipesState extends Equatable {
  const RecipesState();
  
  @override
  List<Object> get props => [];
}

class RecipesInitial extends RecipesState {}
