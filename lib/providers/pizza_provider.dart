// TODO Implement this library.// TODO Implement this library.import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:new_pizza/models/pizza.dart';
import 'package:new_pizza/services/api_service.dart';

class PizzaProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Pizza> _pizzas = [];

  List<Pizza> get pizzas => _pizzas;

  Future<void> fetchPizzas() async {
    try {
      _pizzas = await _apiService.fetchPizzas();
      notifyListeners();
    } catch (e) {
      print('Error fetching pizzas: $e');
    }
  }
}
