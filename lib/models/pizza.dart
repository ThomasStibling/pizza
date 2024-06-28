import 'package:new_pizza/models/ingredient.dart';

class Pizza {
  final String id;
  final String name;
  final double price;
  final String base;
  final List<String> ingredients;
  final String image;
  final String category;
  final List<Ingredient>? elements;

  Pizza(
      {required this.id,
      required this.name,
      required this.price,
      required this.base,
      required this.ingredients,
      required this.image,
      required this.category,
      required this.elements});

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
        id: json['id'],
        name: json['name'],
        price: json['price'].toDouble(),
        base: json['base'],
        ingredients: List<String>.from(json['ingredients']),
        image: json['image'],
        category: json['category'],
        elements: []);
  }

  factory Pizza.fromJsonWithIngredient(Map<String, dynamic> json) {
    return Pizza(
      id: json['data']['id'],
      name: json['data']['name'],
      price: json['data']['price'].toDouble(),
      base: json['data']['base'],
      ingredients: List<String>.from(json['data']['ingredients']),
      image: json['data']['image'],
      category: json['data']['category'],
      elements: json['data']['elements']
          .map<Ingredient>((i) => Ingredient.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'base': base,
        'ingredients': ingredients,
        'image': image,
        'category': category,
        'elements': elements
      };
}
