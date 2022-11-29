import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/home/menu.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/recipe/get_recipe_information_bloc/get_recipe_information_bloc.dart';

void main() => runApp(const RecipeDetails());

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(width:250, child: userMenu(context)),
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: SingleChildScrollView(
        child: _getRecipeInformation()
      )
    );
  }

  BlocConsumer<GetRecipeInformationBloc, GetRecipeInformationState> _getRecipeInformation() {
    return BlocConsumer<GetRecipeInformationBloc, GetRecipeInformationState>(
      listener: (context, GetRecipeInformationState state) {},
      builder: (context, state) {
        if (state.runtimeType == GetRecipeInformationInitial) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                Text('Initial State',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          );
        } else if (state.runtimeType == GetRecipeInformationLoading) {
          return Container(
            height: MediaQuery.of(context).size.height - 173,
            child: Center(
              child: LoadingBouncingGrid.square(
              inverted: true,
              borderColor: Colors.black,
              borderSize: 1.0,
              size: 100.0,
              backgroundColor: Color.fromARGB(255, 122, 39, 160),
                duration: Duration(seconds: 1),
              ),
            ),
          );
        } else if (state.runtimeType == GetRecipeInformationLoaded) {
          final recipe = (state as GetRecipeInformationLoaded).informationLoaded;
          return _recipeInfo(context, recipe);
        } else {
          final error = (state as GetRecipeInformationError).error;
          return Center(
            child: Text(error),
          );
        }
      }
    );
  }
  Widget _recipeInfo(BuildContext context, recipe) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network('${recipe[0]["image"]}')),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              Text('${recipe[0]["title"]}', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(0, 45, 42, 42))
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(
                        FontAwesomeIcons.userGroup, 
                        color: Color.fromARGB(255, 122, 39, 160)
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Servings",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        SizedBox(height: 2),
                        Text('${recipe[0]["servings"]}')
                      ],
                    ),
                    VerticalDivider(thickness: 2, color: Colors.grey),
                    Column(
                      children: [
                        Icon(
                        FontAwesomeIcons.stopwatch, 
                        color: Color.fromARGB(255, 122, 39, 160),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Cooking Time",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        SizedBox(height: 2),
                        Text('${recipe[0]["readyInMinutes"]}')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),)
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for(var i in recipe[0]['extendedIngredients'])
                Text('• ${i["original"]}'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text("Instructions:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),)
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text('${recipe[0]["instructions"]}', textAlign: TextAlign.justify),
            ],
          ),
        ),
        SizedBox(height: 25,)
      ],
    );
  }
}
