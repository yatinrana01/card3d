class Productmodel {
  final String id;
  final String title;
  final String description;
  final int price;
  final String currency;
  final double rating;
  final int stock;
  final String category;
  final String thumbnail;
  final String model3d;
  final bool isfeatured;

  Productmodel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.rating,
    required this.stock,
    required this.category,
    required this.thumbnail,
    required this.model3d,
    required this.isfeatured,
  });

  factory Productmodel.fromJson(Map<String, dynamic> json) {
    return Productmodel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      price: (json['price'] as num?)?.toInt() ?? 0,
      currency: (json['currency'] ?? '').toString(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      category: (json['category'] ?? '').toString(),
      thumbnail: (json['thumbnail'] ?? '').toString(),
      model3d: (json['model3d'] ?? '').toString(),
      isfeatured: json['isFeatured'] as bool? ?? false,
    );
  }
}
