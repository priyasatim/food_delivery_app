import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/database/local/db_helper.dart';
import '../../data/model/category_model.dart';

class CategoriesRepository {

  // Add DB Insert Function
  Future<void> saveCategoriesToDB(List<Category> categories) async {
    final db = await DBHelper.instance.database;

    for (var category in categories) {
      await db.insert(
        'categories',
        category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    print("Categories saved to DB ✅");
  }

  // get data from db
  Future<List<Category>> getCategoriesFromDB() async {
    final db = await DBHelper.instance.database;

    final result = await db.query('categories');

    return result.map((e) => Category.fromMap(e)).toList();
  }


  // Api data
  Future<List<Category>> fetchCategories() async {
    final String response =
    await rootBundle.loadString('assets/json_data/category.json');

    final List<dynamic> data = json.decode(response);

    return data.map((e) => Category.fromMap(e)).toList();
  }


  /// MAIN FUNCTION (use this in UI)
  Future<List<Category>> getCategories({bool? isVeg}) async {
    final db = await DBHelper.instance.database;

    // 🔹 1. Get ALL data from DB
    List<Map<String, dynamic>> result = await db.query('categories');

    // 🔹 2. If DB empty → fetch from API
    if (result.isEmpty) {
      final apiData = await fetchCategories();

      if (apiData.isEmpty) {
        print("No categories found ❌");
        return [];
      }

      // Save to DB
      await saveCategoriesToDB(apiData);

      // Fetch again from DB
      result = await db.query('categories');
    }

    // 🔹 3. Convert to model
    List<Category> categories =
    result.map((e) => Category.fromMap(e)).toList();

    // 🔹 4. Apply Veg Filter (IMPORTANT)
    if (isVeg == true) {
      categories = categories
          .where((c) => c.is_veg == 1)
          .toList();
    }

    return categories;
  }
}