abstract class FoodEvent {}

class LoadFoodDetail extends FoodEvent {
  final int id;

  LoadFoodDetail(this.id);
}