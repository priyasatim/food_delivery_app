import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/category_model.dart';
import '../../../domain/repository/categories_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesRepository repository;
  CategoryBloc({required this.repository}) : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await repository.getCategories();
        emit(CategoryLoaded(categories.cast<Category>()));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}