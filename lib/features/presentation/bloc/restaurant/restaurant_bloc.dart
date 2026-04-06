import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/presentation/bloc/restaurant/restaurant_event.dart';
import 'package:food_delivery_app/features/presentation/bloc/restaurant/restaurant_state.dart';

import '../../../domain/repository/restaurant_repository.dart';
class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantBlocState> {
  final RestaurantRepository repository;

  RestaurantBloc({required this.repository})
      : super(RestaurantBlocInitial()) {

    /// Load ALL data (default)
    on<LoadAllFood>((event, emit) async {
      emit(RestaurantBlocLoading());
      try {
        final data = await repository.getFood();
        emit(RestaurantBlocLoaded(data));
      } catch (e) {
        emit(RestaurantBlocError(e.toString()));
      }
    });

    /// 🔹 Filter by category
    on<FetchFoodByCategory>((event, emit) async {
      emit(RestaurantBlocLoading());
      try {
        final data =
        await repository.fetchFoodByCategory(event.category);

        emit(RestaurantBlocLoaded(data));
      } catch (e) {
        emit(RestaurantBlocError(e.toString()));
      }
    });
  }
}