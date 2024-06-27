import 'package:new_pizza/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem({required this.pizza, required this.quantity});

  double get totalPrice => pizza.price * quantity;

  Map<String, dynamic> toJson() => {
        'pizza': pizza.toJson(),
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      pizza: Pizza.fromJson(json['pizza']),
      quantity: json['quantity'],
    );
  }
}
