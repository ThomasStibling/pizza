// TODO Implement this library.// TODO Implement this library.import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:new_pizza/models/pizza.dart';
import 'package:new_pizza/services/api_service.dart';

class PizzaProvider extends ChangeNotifier {
  List<Pizza> _pizzas = [];
  List<Pizza> _filteredPizzas = [];
  final ApiService _apiService = ApiService();

  List<Pizza> get pizzas => _filteredPizzas;

  PizzaProvider() {
    fetchPizzas();
  }

  Future<void> fetchPizzas() async {
    try {
      _pizzas = await _apiService.fetchPizzas();
      _filteredPizzas = _pizzas;
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to load pizzas');
    }
  }

  void filterPizzas(String query) {
    if (query.isEmpty) {
      _filteredPizzas = _pizzas;
    } else {
      _filteredPizzas = _pizzas
          .where(
              (pizza) => pizza.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
