import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zomato_app/bloc/category/categories_repository.dart';
import 'package:zomato_app/model/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesRepository repository;
  CategoryBloc({required this.repository}) : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await repository.fetchCategories();
        emit(CategoryLoaded(categories.cast<Category>()));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}