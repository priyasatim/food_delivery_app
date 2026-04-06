
import '../../../data/model/food_model.dart';

abstract class FoodState {}

class FoodBlocInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodBlocLoaded extends FoodState {
  final FoodModel food;
  FoodBlocLoaded(this.food);
}

class FoodBlocError extends FoodState {
  final String message;
  FoodBlocError(this.message);
}