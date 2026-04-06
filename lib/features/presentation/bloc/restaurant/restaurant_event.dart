abstract class RestaurantEvent {}

class LoadAllFood extends RestaurantEvent {}

class FetchFoodByCategory extends RestaurantEvent {
  final String category;

  FetchFoodByCategory(this.category);
}