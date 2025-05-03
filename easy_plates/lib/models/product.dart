class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;
  final List<String> ingredients;
  final String categoryId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.ingredients,
    required this.categoryId,
  });

  // من JSON إلى Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients'] ?? []),
      categoryId: json['category_id'].toString(),
    );
  }

  // من Product إلى JSON (اختياري)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'ingredients': ingredients,
      'category_id': categoryId,
    };
  }
}

