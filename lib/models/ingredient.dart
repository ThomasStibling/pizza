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
      id: json['id'],
      name: json['name'],
      category: json['category'],
      image: json['image'],
    );
  }
}
