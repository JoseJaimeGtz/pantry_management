part of 'get_recipe_information_bloc.dart';

abstract class GetRecipeInformationState extends Equatable {
  const GetRecipeInformationState();
  
  @override
  List<Object> get props => [];
}

class GetRecipeInformationInitial extends GetRecipeInformationState {}

class GetRecipeInformationLoading extends GetRecipeInformationState {}

class GetRecipeInformationLoaded extends GetRecipeInformationState {
  final List<dynamic> informationLoaded;
  GetRecipeInformationLoaded({ required this.informationLoaded });
}

class GetRecipeInformationError extends GetRecipeInformationState {
  final String error;
  GetRecipeInformationError({ required this.error });
}

