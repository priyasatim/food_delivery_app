import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/model/category_model.dart';
import '../../data/model/explore_model.dart';
import '../../domain/repository/categories_repository.dart';
import '../../domain/repository/explore_repository.dart';
import 'category_notifier.dart';

/// Repository Provider
final categoryRepositoryProvider = Provider<CategoriesRepository>((ref) {
  return CategoriesRepository();
});

final exploreRepositoryProvider = Provider<ExploreRepository>((ref) {
  return ExploreRepository();
});

// Data Providers
final categoriesProvider =
FutureProvider.family<List<Category>, bool?>((ref, isVeg) async {
  return await CategoriesRepository().getCategories(isVeg: isVeg);
});

final exploreProvider = FutureProvider<List<Explore>>((ref) async {
  final repo = ref.read(exploreRepositoryProvider);
  return repo.fetchExplore();
});

final selectedCategoryProvider =
StateProvider<String>((ref) => "All");