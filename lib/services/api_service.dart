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

  Future<Pizza> fetchPizzaById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/pizzas/$id'));
    if (response.statusCode == 200) {
      return Pizza.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pizza');
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

  Future<Ingredient> fetchIngredientById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/ingredients/$id'));
    if (response.statusCode == 200) {
      return Ingredient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load ingredient');
    }
  }
}