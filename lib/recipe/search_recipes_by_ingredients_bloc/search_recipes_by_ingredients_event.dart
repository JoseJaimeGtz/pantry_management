part of 'search_recipes_by_ingredients_bloc.dart';

abstract class SearchRecipesByIngredientsEvent extends Equatable {
  const SearchRecipesByIngredientsEvent();

  @override
  List<Object> get props => []; // or an empty string ''
}

class SearchRecipesByIngredients extends SearchRecipesByIngredientsEvent {
  final String query;
  SearchRecipesByIngredients({ required this.query });
}
