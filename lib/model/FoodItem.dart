class FoodItem {
  final String name;
  final String image;
  final String price;
  final bool isVeg;
  final bool isRecommended;

  FoodItem({
    required this.name,
    required this.image,
    required this.price,
    this.isVeg = true,
    this.isRecommended = false,
  });
}