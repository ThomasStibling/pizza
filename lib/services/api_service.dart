import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_pizza/models/pizza.dart';
import 'package:new_pizza/models/ingredient.dart';

class ApiService {
  final String baseUrl = 'https://pizzas.shrp.dev/items';

  Future<List<Pizza>> fetchPizzas() async {
    final response = await http.get(Uri.parse('$baseUrl/pizzas'));

    if (response.statusCode == 200) {
      print('success');
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> jsonList = jsonResponse['data'];
      return jsonList.map((json) => Pizza.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pizzas');
    }
  }

  static Future<Pizza> fetchPizzaById(String id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://pizzas.shrp.dev/items/pizzas/$id?fields[]=elements.ingredients_id.*&fields[]=*'));
      //https://pizzas.shrp.dev/items/pizzas/1fa92403-d4e0-401a-9a6a-b5450b5cecf2?fields[]=elements.ingredients_id.*&fields[]=*
      if (response.statusCode == 200) {
        return Pizza.fromJsonWithIngredient(json.decode(response.body));
      } else {
        throw Exception('Failed to load pizza');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Ingredient>> fetchIngredients() async {
    final response = await http.get(Uri.parse('$baseUrl/ingredients'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Ingredient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load ingredients');
    }
  }

  /*static Future<List<Ingredient>> fetchListIngredients(
      List<int> ingredientIds) async {
    List<Ingredient> ingredients = [];
    for (var id in ingredientIds) {
      final response = await http
          //remettre en base url
          .get(Uri.parse('https://pizzas.shrp.dev/items/ingredients/$id'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        ingredients.add(Ingredient.fromJson(jsonResponse));
      } else {
        throw Exception('Failed to load ingredient');
      }
    }
    return ingredients;
  }*/

  Future<Ingredient> fetchIngredientById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/ingredients/$id'));
    if (response.statusCode == 200) {
      return Ingredient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load ingredient');
    }
  }
}
