class Restaurant {
  final int? id;
  final String title;
  final String category;
  final String location;
  final String description;
  final double price;
  final double discountPrice;

  Restaurant({
    this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.description,
    required this.price,
    required this.discountPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'location': location,
      'description': description,
      'price': price,
      'discount_price': discountPrice,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      location: map['location'],
      description: map['description'],
      price: map['price'],
      discountPrice: map['discount_price'],
    );
  }
}