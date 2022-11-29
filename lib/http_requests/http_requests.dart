import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HttpRequest { // Patron Creacional / Singleton
  static final HttpRequest _singleton = HttpRequest._internal();

  factory HttpRequest() {
    return _singleton;
  }

  HttpRequest._internal();

  dynamic _getRecipeContent(response) {
    if (response.statusCode == 200) {
      var _content = jsonDecode(response.body);
      print(_content);
      return _content;
    } else {
      print(response.statusCode);
      print('Response error');
      print(response.body);
    }
  }

  String _makeUrlWithId(X_RapidAPI_Host, id) {
    var incompleteUrl = 'https://${X_RapidAPI_Host}/recipes/${id}';
    return incompleteUrl;
  }

  Future<dynamic> getSimilarRecipes(id) async {
    print('Making Get Similar Recipes Request');
    try {
      await dotenv.load(fileName: ".env");
      var X_RapidAPI_Key = dotenv.env['X-RapidAPI-Key'];
      var X_RapidAPI_Host = dotenv.env['X-RapidAPI-Host'];
      var ENDPOINT = _makeUrlWithId(X_RapidAPI_Host, id);
      var _response = await _getRecipeResponse(ENDPOINT+'/similar', X_RapidAPI_Host, X_RapidAPI_Key); // Patrones de comportamiento / Command
      return _getRecipeContent(_response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getRecipeInformation(id) async {
    print('Making Get Recipes By Ingredients Request');
    try {
      await dotenv.load(fileName: ".env");
      var X_RapidAPI_Key = dotenv.env['X-RapidAPI-Key'];
      var X_RapidAPI_Host = dotenv.env['X-RapidAPI-Host'];
      var ENDPOINT = _makeUrlWithId(X_RapidAPI_Host, id);
      var _response = await _getRecipeResponse(ENDPOINT+'/information', X_RapidAPI_Host, X_RapidAPI_Key);
      return _getRecipeContent(_response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getRecipesByIngredients(ingredients) async {
    print('Making Get Recipes By Ingredients Request');
    try {
      await dotenv.load(fileName: ".env");
      var X_RapidAPI_Key = dotenv.env['X-RapidAPI-Key'];
      var X_RapidAPI_Host = dotenv.env['X-RapidAPI-Host'];
      var ENDPOINT = _makeRecipesByIngredientsURL(X_RapidAPI_Host, ingredients, 10);
      var _response = await _getRecipeResponse(ENDPOINT, X_RapidAPI_Host, X_RapidAPI_Key);
      return _getRecipeContent(_response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> _getRecipeResponse(ENDPOINT, X_RapidAPI_Host, X_RapidAPI_Key) async {
    try {
      print('ENDPOINT: ' + ENDPOINT);
      var response = await http.get(Uri.parse(ENDPOINT), headers: {
          'X-RapidAPI-Host': X_RapidAPI_Host!,
          'X-RapidAPI-Key': X_RapidAPI_Key!
        }
      );
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  String _makeRecipesByIngredientsURL(X_RapidAPI_Host, ingredients, totalRecipesResponse) {
    ingredients = ingredients.toLowerCase();
    ingredients = ingredients.replaceAll(' ', '');
    ingredients = ingredients.replaceAll(',', '%2C');
    var incompleteUrl = 'https://${X_RapidAPI_Host}/recipes/findByIngredients?ingredients=${ingredients}&number=${totalRecipesResponse}&ignorePantry=true&ranking=1';
    return incompleteUrl;
  }
}
