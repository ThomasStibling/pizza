class Ingredient {
  final int id;
  final String name;
  final String category;
  final String image;

  Ingredient({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['ingredients_id']['id'],
      name: json['ingredients_id']['name'],
      category: json['ingredients_id']['category'],
      image: json['ingredients_id']['image'],
    );
  }
}
