import 'dart:convert';

import 'package:flutter/services.dart';

import '../../model/category_model.dart';

class CategoriesRepository {

  Future<List<Category>> fetchCategories() async {
    final String response =
    await rootBundle.loadString('assets/json_data/category.json');

    final List<dynamic> data = json.decode(response);

    return data.map((e) => Category.fromJson(e)).toList();
  }
}