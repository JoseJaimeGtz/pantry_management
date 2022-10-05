import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Recipe_Provider extends ChangeNotifier {
  List<dynamic> _recipes = [];
  List<dynamic> get getRecipes => _recipes;

  Future<dynamic> searchRecipe(recipePath) async {
    File recipe = File(recipePath!);
    Uint8List fileBytes = await recipe.readAsBytesSync();
    String recipeString = base64Encode(fileBytes);

    await dotenv.load(fileName: ".env");
    var api_token = dotenv.env['API_TOKEN'];

    var response = await http.post(Uri.parse('urlAPI'), body: {
      "method": 'recognize',
      "api_token": api_token,
      "audio": "${recipeString}",
      "return": 'apple_music,spotify,deezer',
    });

    if (response.statusCode == 200) {
      var json_response = jsonDecode(response.body);
      notifyListeners();
      return json_response;
    }
  }
  void addRecipe(dynamic recipe){
    _recipes.add(recipe);
    notifyListeners();
  }
}
