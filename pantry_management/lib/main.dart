import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/home_page.dart';
import 'package:pantry_management/bloc/recipes_bloc.dart';
import 'package:pantry_management/signIn_signUp/signIn.dart';
import 'package:pantry_management/signIn_signUp/signUp.dart';

void main() => runApp(BlocProvider(
  create: (context) => RecipesBloc(),
  child: const MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PantryApp',
      home: SignUp(), // HomePage() poner la pantalla aqui
      routes: {
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => SignUp(),
      },
    );
  }
}
