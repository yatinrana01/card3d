class Productmodel {
  String id;
  String title;
  String description;
  int price;
  String currency;
  double rating;
  int stock;
  String category;
  String thumbnail;
  String model3d;
  bool isfeatured;

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
      id: (json['id']).toString(),
      title: json['title'],
      description: json['description'],
      price: json['price'],
      currency: json['currency'],
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      model3d: json['model3d'],
      isfeatured: json['isFeatured'],
    );
  }
}
