part of 'get_recipe_information_bloc.dart';

abstract class GetRecipeInformationEvent extends Equatable {
  const GetRecipeInformationEvent();

  @override
  List<Object> get props => [];
}

class GetRecipeInformation extends GetRecipeInformationEvent {
  final dynamic id;
  GetRecipeInformation({ required this.id });
}
