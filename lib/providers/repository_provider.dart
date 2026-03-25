import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:zomato_app/bloc/category/categories_repository.dart';
import 'package:zomato_app/model/food_model.dart';
import '../bloc/explore/explore_repository.dart';
import '../model/explore_model.dart';
import '../model/category_model.dart';
import 'category_notifier.dart';

/// Repository Provider
final categoryRepositoryProvider = Provider<CategoriesRepository>((ref) {
  return CategoriesRepository();
});

final exploreRepositoryProvider = Provider<ExploreRepository>((ref) {
  return ExploreRepository();
});

// Data Providers
final categoryProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.read(categoryRepositoryProvider);
  return repo.fetchCategories();
});

final exploreProvider = FutureProvider<List<Explore>>((ref) async {
  final repo = ref.read(exploreRepositoryProvider);
  return repo.fetchExplore();
});

final selectedCategoryProvider =
StateProvider<String>((ref) => "All");