import 'package:flutter/material.dart';
import 'package:pantry_management/provider/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemRecipe extends StatelessWidget {
  final dynamic recipe;

  ItemRecipe({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 391,
      height: 400,
      padding: EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                child: Image.network('${recipe["spotify"]["album"]["images"][0]["url"]}', fit: BoxFit.fill),
                onTap: (){
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Redirigir a sitio web'),
                      content: const Text('Será redirigido a opciones para abrir la canción ¿Quieres continuar?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancelar',style: TextStyle(color: Color.fromARGB(250, 140, 130, 190))),
                        ),
                        TextButton(
                          onPressed: () {
                            _launchUrl(recipe["song_link"]);
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('Continuar', style: TextStyle(color: Color.fromARGB(250, 140, 130, 190))),
                        ),
                      ]
                    )
                  );
                },
              ),
            ),
            Positioned( // posicionar en ciertas coordenadas
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
                child: Container(
                  padding: EdgeInsets.all(4),
                  color: Color.fromARGB(243, 60, 95, 190 ),
                  child: Column(
                    children: [
                      Text(
                        '${recipe["title"]}', 
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        '${recipe["artist"]}', 
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
                          context.read<Recipe_Provider>().addRecipe(recipe);
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

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
