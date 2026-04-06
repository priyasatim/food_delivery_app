import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/data/model/food_model.dart';
import 'package:food_delivery_app/features/presentation/bloc/food/food_event.dart';
import 'package:food_delivery_app/features/presentation/bloc/food/food_state.dart';

import '../../../domain/repository/restaurant_repository.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final RestaurantRepository repository;

  FoodBloc({required this.repository})
      : super(FoodBlocInitial()) {

    /// Load ALL data (default)
    on<LoadFoodDetail>((event, emit) async {
      emit(FoodLoading());
      try {
        final data = await repository.getProductDetails(
          event.id,
        );

        if (data != null) {
          emit(FoodBlocLoaded(data));
        } else {
          emit(FoodBlocError("No product found"));
        }
      } catch (e) {
        emit(FoodBlocError(e.toString()));
      }
    });
  }
}