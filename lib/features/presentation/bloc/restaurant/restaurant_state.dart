
import '../../../data/model/food_model.dart';

abstract class RestaurantBlocState {}

class RestaurantBlocInitial extends RestaurantBlocState {}

class RestaurantBlocLoading extends RestaurantBlocState {}

class RestaurantBlocLoaded extends RestaurantBlocState {
  final List<FoodModel> food;
  RestaurantBlocLoaded(this.food);
}

class RestaurantBlocError extends RestaurantBlocState {
  final String message;
  RestaurantBlocError(this.message);
}