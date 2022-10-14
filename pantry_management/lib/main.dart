import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/home/home_page.dart';
import 'package:pantry_management/bloc/recipes_bloc.dart';
import 'package:pantry_management/pantry/your_food.dart';
import 'package:pantry_management/recipe/item_recipe.dart';
import 'package:pantry_management/recipe/recipes.dart';
import 'package:pantry_management/signIn_signUp/signIn.dart';
import 'package:pantry_management/signIn_signUp/signUp.dart';
import 'package:pantry_management/supermarket/superMarket.dart';

void main() => runApp(BlocProvider(
  create: (context) => RecipesBloc(),
  child: const MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 122, 39, 160)),
        ),
      title: 'PantryApp',
      home: YourFood(), // HomePage() poner la pantalla aqui
      routes: {
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => SignUp(),
        '/superMarket': (context) => SuperMarket(),
        '/recipes': (context) => Recipes(),
        '/yourFood':(context) => YourFood()
      },
    );
  }
}
