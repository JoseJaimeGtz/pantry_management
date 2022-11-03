import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/home/menu.dart';
import 'package:pantry_management/recipe/item_recipe.dart';
import 'package:pantry_management/recipe/search_recipes_by_ingredients_bloc/search_recipes_by_ingredients_bloc.dart';

class Recipes extends StatelessWidget {

  Recipes({
    Key? key,
  }) : super(key: key);

  final _query = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(width:250, child: userMenu(context)),
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: Column(
        children: [
          SafeArea(
            top: false,
            bottom: false,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _query,
                    decoration: InputDecoration(
                      labelText: 'ingredient1, ingredient2, ingredient3',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          BlocProvider.of<SearchRecipesByIngredientsBloc>(context).add(
                            SearchRecipesByIngredients(query: _query.text)
                          );
                        },
                      )
                    ),
                  ),
                ),
                _searchRecipesByIngredients(),
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _recipesArea(BuildContext context, recipes) {
    return Container(
      height: MediaQuery.of(context).size.height - 103,
      child: _recipesList(context, recipes),
    );
  }

  Widget _recipesList(BuildContext context, recipes) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        var _itemRecipe = recipes[index];
        print(_itemRecipe);
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/recipeDetails', arguments: recipes[index]['id']), // del index on recipes[index]['id']
          child: ItemRecipe(recipe: _itemRecipe)
          );
      },
    );
  }

  BlocConsumer<SearchRecipesByIngredientsBloc, SearchRecipesByIngredientsState> _searchRecipesByIngredients() {
    return BlocConsumer<SearchRecipesByIngredientsBloc, SearchRecipesByIngredientsState>(
      listener: (context, SearchRecipesByIngredientsState state) {},
      builder: (context, state) {
        if (state.runtimeType == SearchRecipesByIngredientsInitial) {
          return Expanded(
            child: Center(
              child: Text('Search something'),
            )
          );
        } else if (state.runtimeType == SearchRecipesByIngredientsLoading) {
          return Column(
            children: [
              //shimmers
              Text('Mostrar config de shimers aqui')
            ],
          );
        } else if (state.runtimeType == SearchRecipesByIngredientsLoaded) {
          final recipes = (state as SearchRecipesByIngredientsLoaded).recipesLoaded;
          return _recipesArea(context, recipes);
        } else {
          final error = (state as SearchRecipesByIngredientsError).error;
          return Expanded(
            child: Center(
              child: Text(error),
            ),
          );
        }
      }
    );
  }
}

// TODO: no se como hacer la llamada del bloc sin la necesidad de ejecutarlo en un onTap