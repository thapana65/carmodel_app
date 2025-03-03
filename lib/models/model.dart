class CarModel {
  String id;
  String brand;
  String model;
  int year;
  String category;
  double price;
  String color;
  DateTime launchDate;
  String imageUrl;
  bool isFavorite;
  DateTime createdAt;

  CarModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.category,
    required this.price,
    required this.color,
    required this.launchDate,
    required this.imageUrl,
    required this.createdAt,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "model": model,
        "year": year,
        "category": category,
        "price": price,
        "color": color,
        "launchDate": launchDate.toIso8601String(),
        "imageUrl": imageUrl,
        "isFavorite": isFavorite,
        "createdAt": createdAt.toIso8601String(),
      };

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        year: json["year"],
        category: json["category"],
        price: json["price"],
        color: json["color"],
        launchDate: DateTime.parse(json["launchDate"]),
        imageUrl: json["imageUrl"],
        isFavorite: json["isFavorite"] ?? false,
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
