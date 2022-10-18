import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/provider/recipe_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(const RecipeInformation());

class RecipeInformation extends StatelessWidget {
  const RecipeInformation({super.key, this.selectedRecipe});
  final dynamic selectedRecipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedRecipe["title"]}'),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            tooltip: 'Agregar a favoritos',
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Agregar a Favoritos'),
                  content: const Text('El elemento será agregado a tus Favoritos ¿Quieres continuar?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancelar', style: TextStyle(color: Color.fromARGB(250, 140, 130, 190))),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<Recipe_Provider>().addRecipe(selectedRecipe);
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('Continuar', style: TextStyle(color: Color.fromARGB(250, 140, 130, 190))),
                    ),
                  ]
                )
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.network('${selectedRecipe["spotify"]["album"]["images"][0]["url"]}', fit: BoxFit.fill),
            SizedBox(height: 50,),
            Text('${selectedRecipe["title"]}', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('${selectedRecipe["album"]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('${selectedRecipe["artist"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
            Text('${selectedRecipe["release_date"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
            SizedBox(height: 25,),
            Divider(thickness: 1),
            Text('Abrir con:'),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  tooltip: 'Ver en Spotify',
                  splashColor: Colors.transparent,
                  icon: Icon(FontAwesomeIcons.spotify, size: 50,),
                  onPressed: () {
                    _launchUrl(selectedRecipe["spotify"]["external_urls"]["spotify"]);
                  },
                ),
                IconButton(
                  tooltip: 'Ver en Podcast',
                  splashColor: Colors.transparent,
                  icon: Icon(FontAwesomeIcons.podcast, size: 50,),
                  onPressed: () {
                    _launchUrl(selectedRecipe["song_link"]);
                  },
                ),
                IconButton(
                  tooltip: 'Ver en Apple',
                  splashColor: Colors.transparent,
                  icon: Icon(FontAwesomeIcons.apple, size: 50,),
                  onPressed: () {
                    _launchUrl(selectedRecipe["apple_music"]["url"]);
                  },
                ),
              ],
            )
          ]
        )
      )
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
