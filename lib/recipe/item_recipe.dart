import 'dart:ui' as ui;
import 'package:flutter/material.dart';

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
                onTap: (){   //dar click en la imagen para ver detalles de la receta
                Navigator.pushNamed(context, '/recipeDetails'); // Dummy
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
