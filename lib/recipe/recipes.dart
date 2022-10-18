import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/provider/recipe_provider.dart';
import 'package:pantry_management/recipe/item_recipe.dart';
import 'package:pantry_management/home/menu.dart';

class Recipes extends StatelessWidget {
  final List<Map<String, String>> _listElements = [
    {
      "title": "Arroz con pollo",
      "description": "",
      "image":
          "https://www.unileverfoodsolutions.com.co/dam/global-ufs/mcos/nola/colombia/calcmenu/recipes/CO-recipes/rice-dishes/arroz-con-pollo/main-header.jpg",
    },
    {
      "title": "Mole con pollo",
      "description": "",
      "image":
          "https://www.recetasnestle.com.mx/sites/default/files/styles/recipe_detail_desktop/public/srh_recipes/c9de6cbd070d8bf040606021bb3983de.jpg.webp?itok=_rJ3NM-A",
    },
    {
      "title": "Carnitas",
      "description": "",
      "image":
          "https://patijinich.com/es/wp-content/uploads/sites/3/2018/08/702-carnitas-caramelizadas.jpg",
    },
    {
      "title": "Huevo con chorizo",
      "description": "",
      "image":
          "https://www.comedera.com/wp-content/uploads/2021/03/shutterstock_1379830838-huevos-con-chorizo.jpg",
    },
  ];

  Recipes({
    Key? key,
  }) : super(key: key);

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
            child: _recipesArea(context),
          )
        ],
      ),
    );
  }

  Widget _recipesArea(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 103,
      child: _recipesList(context),
    );
  }

  Widget _recipesList(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _listElements
          .length, //context.watch<Recipe_Provider>().getRecipes.length,
      itemBuilder: (BuildContext context, int index) {
        //var _itemRecipe = context.watch<Recipe_Provider>().getRecipes[index];
        var _itemRecipe = _listElements[index];
        print(_itemRecipe);
        return ItemRecipe(recipe: _itemRecipe);
      },
    );
  }

  
}
