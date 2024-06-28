class Pizza {
  final String id;
  final String name;
  final double price;
  final String base;
  final List<String> ingredients;
  final String image;
  final String category;
  final List<int> elements;

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
        elements: List<int>.from(json['elements']));
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
