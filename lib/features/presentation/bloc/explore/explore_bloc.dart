import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/explore_model.dart';
import 'explore_event.dart';
import '../../../domain/repository/explore_repository.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final
  ExploreRepository repository;
  ExploreBloc({required this.repository}) : super(ExploreInitial()) {
    on<LoadExplore>((event, emit) async {
      emit(ExploreLoading());
      try {
        final explore = await repository.fetchExplore();
        emit(ExploreLoaded(explore.cast<Explore>()));
      } catch (e) {
        // emit(ExploreLoaded(e.toString() as List<Explore>));
      }
    });
  }
}