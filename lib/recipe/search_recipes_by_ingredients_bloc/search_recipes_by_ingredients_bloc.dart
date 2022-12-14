import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pantry_management/http_requests/http_requests.dart';

part 'search_recipes_by_ingredients_event.dart';
part 'search_recipes_by_ingredients_state.dart';

class SearchRecipesByIngredientsBloc extends Bloc<SearchRecipesByIngredientsEvent, SearchRecipesByIngredientsState> {
  SearchRecipesByIngredientsBloc() : super(SearchRecipesByIngredientsInitial()) {
    on<SearchRecipesByIngredientsEvent>(_searchRecipesByIngredients);
  }

  Future<void> _searchRecipesByIngredients(event, emit) async {
    emit(SearchRecipesByIngredientsLoading()); // Emit Loading when a user search by ingredients

    var request = HttpRequest();

    try {
      final res = await request.getRecipesByIngredients(event.query); // Código de cliente
      if (res[0] != null) {

        // All Recipes
        var recipes = [];
        for (var recipe in res) {

          // Recipe id
          var id;
          try {
            id = recipe['id'];
          } catch (e) {
            id = 0; // null
          }
          
          // Recipe title
          var title;
          try {
            title = recipe['title'];
          } catch (e) {
            title = 'No Title Available'; // null
          }

          // Recipe image
          var image;
          try {
            image = recipe['image'];
          } catch (e) {
            image = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png'; // img not found
          }

          recipes.add(
            {
              'id': id,
              'title': title,
              'image': image,
            }
          );
        }
        print(res);
        emit(SearchRecipesByIngredientsLoaded(recipesLoaded: recipes));
      } else {
        emit(SearchRecipesByIngredientsError(error: 'No Recipes Found'));
        return;
      }
    } catch (e) {
      emit(SearchRecipesByIngredientsError(error: 'Something Was Wrong! $e'));
    }
  }
}
