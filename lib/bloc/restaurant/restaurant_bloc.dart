import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zomato_app/bloc/restaurant/restaurant_event.dart';
import 'package:zomato_app/bloc/restaurant/restaurant_repository.dart';
import 'package:zomato_app/bloc/restaurant/restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantBlocState> {
  final RestaurantRepository repository;

  RestaurantBloc({required this.repository})
      : super(RestaurantBlocInitial()) {

    /// Load ALL data (default)
    on<LoadAllFood>((event, emit) async {
      emit(RestaurantBlocLoading());
      try {
        final data = await repository.fetchFood();
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