class FoodModel {

  final int? id;
  final String? title;
  final String image;
  final String time;
  final double price;
  final String category;

  FoodModel({this.id, required this.title, required this.image,required this.time, required this.price, required this.category});

  /// JSON → Model
  factory FoodModel.fromMap(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'], // optional for DB
      title: json['title'],
      image: json['image'],
      time: json['time'],
      price: json['price'],
      category: json['category'],
    );
  }

  /// Model → SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'time': time,
      'price': price,
      'category': category,
    };
  }
}