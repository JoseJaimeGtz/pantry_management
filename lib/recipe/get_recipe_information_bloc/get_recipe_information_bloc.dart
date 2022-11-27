import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pantry_management/http_requests/http_requests.dart';

part 'get_recipe_information_event.dart';
part 'get_recipe_information_state.dart';

class GetRecipeInformationBloc extends Bloc<GetRecipeInformationEvent, GetRecipeInformationState> {
  GetRecipeInformationBloc() : super(GetRecipeInformationInitial()) {
    on<GetRecipeInformationEvent>(_getRecipeInformation);
  }

  Future<void> _getRecipeInformation(event, emit) async {
    emit(GetRecipeInformationLoading());

    var request = HttpRequest();

    try {
      final res = await request.getRecipeInformation(event.id);
      if (res[0] != null) {

        // Recipe Information
        var recipeDetails = [];
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
            title = '-'; // null
          }

          // Recipe image
          var image;
          try {
            image = recipe['image'];
          } catch (e) {
            image = ''; // img not found
          }

          // servings
          var servings;
          try {
            servings = recipe['servings'];
          } catch (e) {
            servings = null;
          }

          // instructions
          var instructions;
          try {
            instructions = recipe['instructions'];
          } catch (e) {
            instructions = '-'; // instructions not found
          }

          // ready In Minutes
          var readyInMinutes;
          try {
            readyInMinutes = recipe['readyInMinutes'];
          } catch (e) {
            readyInMinutes = null; // readyInMinutes not found
          }

          // Recipe Extended Ingredients
          var extendedIngredients;
          try {
            extendedIngredients = recipe['extendedIngredients'];
          } catch (e) {
            extendedIngredients = []; // extendedIngredients not found
          }

          recipeDetails.add(
            {
              'id': id,
              'title': title,
              'image': image,
              'servings': servings,
              'instructions': instructions,
              'readyInMinutes': readyInMinutes,
              'extendedIngredients': extendedIngredients
            }
          );
        }
        print(res);
        emit(GetRecipeInformationLoaded(informationLoaded: recipeDetails));
      } else {
        emit(GetRecipeInformationError(error: 'No Information Found'));
      }
    } catch (e) {
      emit(GetRecipeInformationError(error: 'Something Was Wrong! $e'));
    }
  }
}
