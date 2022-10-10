import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/provider/recipe_provider.dart';
import 'package:pantry_management/recipe/item_recipe.dart';

class Recipes extends StatelessWidget {

  final List<Map<String, String>> _listElements = [
    {
      "title": "Arroz con pollo",
      "description": "",
      "image": "https://i.imgur.com/tpHc9cS.jpg",
    },
    {
      "title": "Mole con pollo",
      "description": "",
      "image": "https://i.imgur.com/0NTTbFn.jpg",
    },
    {
      "title": "Carnitas",
      "description": "",
      "image": "https://i.imgur.com/noNCN3V.jpg",
    },
    {
      "title": "Huevo con chorizo",
      "description": "",
      "image": "https://i.imgur.com/trdzMAl.jpg",
    },
  ];
  

  Recipes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: Column(
        children: [
          _tracksArea(context),
        ],
      )
    );
  }

  Widget _tracksArea(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 87,
      child: _tracksList(context),
    );
  }

  Widget _tracksList(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      //shrinkWrap: true,
      itemCount: context.watch<Recipe_Provider>().getRecipes.length,
      itemBuilder: (BuildContext context, int index) {
        var _itemRecipe = context.watch<Recipe_Provider>().getRecipes[index];
        return ItemRecipe(recipe: _itemRecipe);
      },
    );
  }
}
