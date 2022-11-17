import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_recipe_information_event.dart';
part 'get_recipe_information_state.dart';

class GetRecipeInformationBloc extends Bloc<GetRecipeInformationEvent, GetRecipeInformationState> {
  GetRecipeInformationBloc() : super(GetRecipeInformationInitial()) {
    on<GetRecipeInformationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
