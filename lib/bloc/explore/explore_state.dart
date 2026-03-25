import 'package:zomato_app/model/explore_model.dart';

import '../../model/category_model.dart';

abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<Explore> explore;
  ExploreLoaded(this.explore);
}

class ExploreError extends ExploreState {
  final String message;
  ExploreError(this.message);
}