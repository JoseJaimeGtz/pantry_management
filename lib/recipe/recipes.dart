import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/home/menu.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:pantry_management/recipe/item_recipe.dart';
import 'package:pantry_management/recipe/search_recipes_by_ingredients_bloc/search_recipes_by_ingredients_bloc.dart';

class Recipes extends StatelessWidget {

  Recipes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(width:250, child: userMenu(context)),
      appBar: AppBar(
        title: const Text('Recipes'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: MySearchDelegate(),
              );
            }
          )
        ],
      ),
      body: Column(
        children: [
          SafeArea(
            top: false,
            bottom: false,
            child: Stack(
              children: [
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
          onTap: () => Navigator.pushNamed(
            context,
            '/recipeDetails',
            arguments: recipes[index]['id']
          ), // del index on recipes[index]['id']
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
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text('Search recipes by ingredients',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ),
          );
        } else if (state.runtimeType == SearchRecipesByIngredientsLoading) {
          return Column(
            children: [
              //shimmers
              VideoShimmer(),
              VideoShimmer(),
              VideoShimmer(),
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

class MySearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    ),
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        if (query.isNotEmpty) {
        BlocProvider.of<SearchRecipesByIngredientsBloc>(context).add(
          SearchRecipesByIngredients(query: query));
        close(context, null);
        }
      },
    ),
  ];

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      'sugar',
      'apple',
      'flour',
      'onion',
      'carrot'
    ];
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
          },
        );
      },
    );
  }
}
