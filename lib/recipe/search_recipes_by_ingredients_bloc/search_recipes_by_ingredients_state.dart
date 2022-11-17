part of 'search_recipes_by_ingredients_bloc.dart';

abstract class SearchRecipesByIngredientsState extends Equatable {
  const SearchRecipesByIngredientsState();
  
  @override
  List<Object> get props => [];
}

class SearchRecipesByIngredientsInitial extends SearchRecipesByIngredientsState {}

class SearchRecipesByIngredientsLoading extends SearchRecipesByIngredientsState {}

class SearchRecipesByIngredientsLoaded extends SearchRecipesByIngredientsState {
  final List<dynamic> recipesLoaded;
  SearchRecipesByIngredientsLoaded({ required this.recipesLoaded });
}

class SearchRecipesByIngredientsError extends SearchRecipesByIngredientsState {
  final String error;
  SearchRecipesByIngredientsError({ required this.error });
}
