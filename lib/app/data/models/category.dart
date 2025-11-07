class Category {
  final String id;
  final String name;
  final String description;
  final int productCount;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.productCount,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      productCount: json['productCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'productCount': productCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
