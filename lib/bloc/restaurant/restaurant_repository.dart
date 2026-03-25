
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zomato_app/model/food_model.dart';

class RestaurantRepository {

  /// Load ALL food from JSON
  Future<List<FoodModel>> fetchFood() async {
    final String response =
    await rootBundle.loadString('assets/json_data/food.json');

    final List<dynamic> data = json.decode(response);

    return data.map((e) => FoodModel.fromJson(e)).toList();
  }

  /// Filter by category
  Future<List<FoodModel>> fetchFoodByCategory(String category) async {
    final allFood = await fetchFood();

    // Handle "All"
    if (category.toLowerCase() == "all") {
      return allFood;
    }

    // Filter
    return allFood
        .where((item) =>
    item.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}