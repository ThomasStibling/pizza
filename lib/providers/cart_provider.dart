import 'package:flutter/foundation.dart';
import 'package:new_pizza/models/cart_item.dart';
import 'package:new_pizza/models/pizza.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  double _totalPrice = 0.0;

  List<CartItem> get items => _items;
  double get totalPrice => _totalPrice;

  void addItem(Pizza pizza) {
    final index = _items.indexWhere((item) => item.pizza.id == pizza.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(pizza: pizza, quantity: 1));
    }
    _calculateTotalPrice();
    _saveCartToPrefs();
    notifyListeners();
  }

  void removeItem(String pizzaId) {
    _items.removeWhere((item) => item.pizza.id == pizzaId);
    _calculateTotalPrice();
    _saveCartToPrefs();
    notifyListeners();
  }

  void updateQuantity(String pizzaId, int quantity) {
    final index = _items.indexWhere((item) => item.pizza.id == pizzaId);
    if (index >= 0) {
      _items[index].quantity = quantity;
      if (_items[index].quantity == 0) {
        _items.removeAt(index);
      }
    }
    _calculateTotalPrice();
    _saveCartToPrefs();
    notifyListeners();
  }

  void _calculateTotalPrice() {
    _totalPrice = _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> _saveCartToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems =
        _items.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('cartItems', cartItems);
  }

  Future<void> loadCartFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cartItems');
    if (cartItems != null) {
      _items = cartItems
          .map((item) => CartItem.fromJson(json.decode(item)))
          .toList();
      _calculateTotalPrice();
    }
  }
}

extension CartItemSerialization on CartItem {
  Map<String, dynamic> toJson() => {
        'pizza': pizza.toJson(),
        'quantity': quantity,
      };

  static CartItem fromJson(Map<String, dynamic> json) => CartItem(
        pizza: Pizza.fromJson(json['pizza']),
        quantity: json['quantity'],
      );
}
