

import '../../../data/model/explore_model.dart';

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