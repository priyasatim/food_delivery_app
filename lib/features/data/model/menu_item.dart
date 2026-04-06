class MenuItem {
  final int id;
  final int restaurantId;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String imageUrl;
  final bool isVeg;

  MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
    required this.isVeg,
  });
}