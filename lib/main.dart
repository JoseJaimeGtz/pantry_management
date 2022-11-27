import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pantry_management/settings.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:pantry_management/recipe/recipes.dart';
import 'package:pantry_management/pantry/your_food.dart';
import 'package:pantry_management/signIn_signUp/signIn.dart';
import 'package:pantry_management/signIn_signUp/signUp.dart';
import 'package:pantry_management/recipe/recipe_details.dart';
import 'package:pantry_management/supermarket/superMarket.dart';
import 'package:pantry_management/recipe/get_recipe_information_bloc/get_recipe_information_bloc.dart';
import 'package:pantry_management/recipe/search_recipes_by_ingredients_bloc/search_recipes_by_ingredients_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'home/home_page.dart';
import 'signIn_signUp/auth_bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetRecipeInformationBloc()),
        BlocProvider(create: (context) => SearchRecipesByIngredientsBloc()),
        BlocProvider(create: (context) => AuthBloc()..add(VerifyAuthEvent())),
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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 122, 39, 160)),
      ),
      title: 'PantryApp',
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is WrongPasswordState) {
            //print("Error");
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Oops...',
              text: 'Verify your email and password',
            );
          }
          else if (state is CreateUserError){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Oops...',
              text: 'Email and password already in use',
            );
          }
          else if (state is CreateUserSuccess){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'Success',
              text: 'Account created successfully',
            );
          }
        },
        builder: (context, state) {
          print(state.toString());
          if (state is AuthSuccessState) {
            return YourFood();
          } else if (state is UnAuthState ||
              state is AuthErrorState ||
              state is SignOutSuccessState ||
              state is WrongPasswordState || state is CreateUserSuccess) {
            return SignIn();
          } else if (state is CreateUserError){
            return SignUp();
          }
          return //LoadingFadingLine.circle millisecods 300
            Center(
            child: LoadingBouncingGrid.square(
            inverted: true,
            borderColor: Colors.black,
            borderSize: 1.0,
            size: 100.0,
            backgroundColor: Color.fromARGB(255, 122, 39, 160),
            duration: Duration(seconds: 1),
          ));
        },
      ),
      routes: {
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => SignUp(),
        '/recipes': (context) => Recipes(),
        '/yourFood': (context) => YourFood(),
        '/settings': (context) => Settings(),
        '/superMarket': (context) => SuperMarket(),
        '/recipeDetails': (context) => RecipeDetails(),
      },
    );
  }
}
