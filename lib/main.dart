import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/settings.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:pantry_management/recipe/recipes.dart';
import 'package:pantry_management/pantry/your_food.dart';
import 'package:pantry_management/signIn_signUp/signIn.dart';
import 'package:pantry_management/signIn_signUp/signUp.dart';
import 'package:pantry_management/recipe/recipe_details.dart';
import 'package:pantry_management/supermarket/superMarket.dart';
// import 'package:pantry_management/recipe/bloc/recipes_bloc.dart';
import 'package:pantry_management/recipe/get_recipe_information_bloc/get_recipe_information_bloc.dart';
import 'package:pantry_management/recipe/search_recipes_by_ingredients_bloc/search_recipes_by_ingredients_bloc.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
runApp(  
  MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GetRecipeInformationBloc()),
      BlocProvider(create: (context) => SearchRecipesByIngredientsBloc()),
    ],
    child: MyApp(),
  ),
);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 122, 39, 160)
        ),
      ),
      title: 'PantryApp',
      home: SuperMarket(), // HomePage() poner la pantalla aqui
      routes: {
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => SignUp(),
        '/recipes': (context) => Recipes(),
        '/yourFood':(context) => YourFood(),
        '/settings': (context) => Settings(),
        '/superMarket': (context) => SuperMarket(),
        '/recipeDetails': (context) => RecipeDetails(),
      },
    );
  }
}
