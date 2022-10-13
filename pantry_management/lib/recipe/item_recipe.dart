import 'package:flutter/material.dart';
import 'package:pantry_management/provider/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class ItemRecipe extends StatelessWidget {
  final dynamic recipe;

  ItemRecipe({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      padding: EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                child: Image.network(
                  '${recipe["image"]}',
                 fit: BoxFit.fill),
                onTap: (){
                },
              ),
            ),
            Positioned( // posicionar en ciertas coordenadas
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Color.fromARGB(140, 122, 39, 160),
                    child: Column(
                      children: [
                        Text(
                          '${recipe["title"]}', 
                          style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: IconButton(
                enableFeedback: false,
                tooltip: "Quitar de favoritos",
                splashColor: Colors.transparent,
                icon: Icon(Icons.favorite, color: Colors.white, size: 20,),
                color: Colors.white,
                onPressed: () {
                  showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Quitar de Favoritos'),
                    content: const Text('El elemento será eliminado de tus Favoritos ¿Quieres continuar?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancelar', style: TextStyle(color: Color.fromARGB(250, 140, 130, 190))),
                      ),
                      TextButton(
                        onPressed: () {
                          //context.read<Recipe_Provider>().addRecipe(recipe);
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('Continuar', style: TextStyle(color: Color.fromARGB(250, 140, 130, 190))),
                      ),
                    ]
                  )
                );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

 /* Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }*/
}
