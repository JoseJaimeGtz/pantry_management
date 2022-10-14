import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/bloc/recipes_bloc.dart';
import 'package:pantry_management/pantry/your_food.dart';
import 'package:pantry_management/recipe/recipes.dart';
import 'package:pantry_management/settings.dart';
import 'package:pantry_management/signIn_signUp/signIn.dart';
import 'package:pantry_management/signIn_signUp/signUp.dart';
import 'package:pantry_management/supermarket/superMarket.dart';

void main() => runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => RecipesBloc()),
    ],
    child: MyApp(),
  ),
);

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
      home: Recipes(), // HomePage() poner la pantalla aqui
      routes: {
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => SignUp(),
        '/recipes': (context) => Recipes(),
        '/yourFood':(context) => YourFood(),
        '/settings': (context) => Settings(),
        '/superMarket': (context) => SuperMarket(),
      },
    );
  }
}
