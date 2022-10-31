import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_recipes_by_ingredients_event.dart';
part 'search_recipes_by_ingredients_state.dart';

class SearchRecipesByIngredientsBloc extends Bloc<SearchRecipesByIngredientsEvent, SearchRecipesByIngredientsState> {
  SearchRecipesByIngredientsBloc() : super(SearchRecipesByIngredientsInitial()) {
    on<SearchRecipesByIngredientsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
