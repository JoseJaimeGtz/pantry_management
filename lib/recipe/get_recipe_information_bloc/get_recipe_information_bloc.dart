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

    print('Haciendo request');

    try {
      final res = await request.getRecipeInformation(event.id);
      if (res.length != 0) {
        // Recipe Information
        var recipeDetails = [];

        // Recipe id
        var id;
        try {
          id = res['id'];
        } catch (e) {
          id = 0; // null
        }

        // Recipe title
        var title;
        try {
          title = res['title'];
        } catch (e) {
          title = 'No Title Available'; // null
        }

        // Recipe image
        var image;
        try {
          image = res['image'];
        } catch (e) {
          image = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png'; // img not found
        }

        // servings
        var servings;
        try {
          servings = res['servings'];
        } catch (e) {
          servings = 0;
        }

        // instructions
        var instructions;
        try {
          instructions = res['instructions'];
        } catch (e) {
          instructions = 'No Instructions Available'; // instructions not found
        }

        // ready In Minutes
        var readyInMinutes;
        try {
          readyInMinutes = res['readyInMinutes'];
        } catch (e) {
          readyInMinutes = 0; // readyInMinutes not found
        }

        // Recipe Extended Ingredients
        var extendedIngredients;
        try {
          extendedIngredients = res['extendedIngredients'];
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
        emit(GetRecipeInformationLoaded(informationLoaded: recipeDetails));
      } else {
        emit(GetRecipeInformationError(error: 'No Information Found'));
        return;
      }
    } catch (e) {
      emit(GetRecipeInformationError(error: 'Something Was Wrong! $e'));
    }
  }
}
