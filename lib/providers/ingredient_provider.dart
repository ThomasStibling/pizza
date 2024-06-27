import 'package:flutter/foundation.dart';
import 'package:new_pizza/models/ingredient.dart';
import 'package:new_pizza/services/api_service.dart';

class IngredientProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Ingredient> _ingredients = [];

  List<Ingredient> get ingredients => _ingredients;

  Future<void> fetchIngredients() async {
    try {
      _ingredients = await _apiService.fetchIngredients();
      notifyListeners();
    } catch (e) {
      print('Error fetching ingredients: $e');
    }
  }
}
