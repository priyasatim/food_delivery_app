import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SelectedCategoryIndexNotifier extends StateNotifier<int> {
  SelectedCategoryIndexNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

  void reset() {
    state = 0;
  }
}