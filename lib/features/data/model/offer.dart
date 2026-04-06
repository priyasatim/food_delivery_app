class Offer {
  final int id;
  final int restaurantId;
  final String title;
  final String description;
  final double discountPercentage;

  Offer({
    required this.id,
    required this.restaurantId,
    required this.title,
    required this.description,
    required this.discountPercentage,
  });
}