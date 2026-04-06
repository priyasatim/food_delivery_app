
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/database/local/db_helper.dart';
import '../../data/model/food_model.dart';

class RestaurantRepository {

  /// Fetch from API (or JSON for now)
  Future<List<FoodModel>> fetchFood() async {
    final String response =
    await rootBundle.loadString('assets/json_data/restaurant.json');

    final List<dynamic> data = json.decode(response);

    return data.map((e) => FoodModel.fromMap(e)).toList();
  }

  /// Filter by category
  Future<List<FoodModel>> fetchFoodByCategory(String category) async {
    final allFood = await getFood();

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

  // save api to db
  Future<void> saveFoodToDB(List<FoodModel> foodList) async {
    final db = await DBHelper.instance.database;

    await db.transaction((txn) async {
      for (var food in foodList) {
        await txn.insert(
          'restaurants', // ✅ FIX
          food.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });

    print("Saved to DB ✅");
  }

  /// Get from DB
  Future<List<FoodModel>> getFoodFromDB() async {
    final db = await DBHelper.instance.database;

    final result = await db.query('restaurants');

    return result.map((e) => FoodModel.fromMap(e)).toList();
  }


  /// MAIN FUNCTION (Use this in UI)
  Future<List<FoodModel>> getFood() async {
    final dbData = await getFoodFromDB();

    // ✅ Return DB data if exists
    if (dbData.isNotEmpty) {
      return dbData;
    }

    // 🔄 Fetch from API
    final apiData = await fetchFood();

    // ❗ If API also empty
    if (apiData.isEmpty) {
      print("No data found anywhere ❌");
      return [];
    }

    // 💾 Save to DB
    await saveFoodToDB(apiData);

    return apiData;
  }

  Future<void> insertJsonToDB() async {
    final db = await DBHelper.instance.database;

    final String response =
    await rootBundle.loadString('assets/json_data/restaurant_details.json');

    final data = json.decode(response);

    final restaurants = data['restaurants'];

    for (var restaurant in restaurants) {
      /// 🟢 Insert Restaurant
      await db.insert(
        'restaurant_detail',
        {
          'id': restaurant['id'],
          'name': restaurant['name'],
          'location': restaurant['location'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      /// 🟢 Insert Foods
      final foods = restaurant['foods'] as List;

      for (var food in foods) {
        await db.insert(
          'foods',
          {
            'id': food['id'],
            'title': food['title'],
            'image': food['image'],
            'time': food['time'],
            'discount': food['discount'],
            'category': food['category'],
            'price': food['price'],
            'restaurant_id': restaurant['id'], // 🔥 important
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    print("✅ JSON inserted into DB");
  }


  // Get Product Details by ID
  Future<FoodModel?> getProductById(int id) async {
    final db = await DBHelper.instance.database;

    final result = await db.query(
      'restaurant_detail',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return FoodModel.fromMap(result.first); // ✅ single product
    }

    return null;
  }

  // GET FOODS BY RESTAURANT ID
  Future<List<FoodModel>> getFoodsByRestaurantId(int restaurantId) async {
    final db = await DBHelper.instance.database;

    final result = await db.query(
      'foods',
      where: 'restaurant_id = ?',
      whereArgs: [restaurantId],
    );

    return result.map((e) => FoodModel.fromMap(e)).toList();
  }

  Future<FoodModel?> getProductDetails(int id) async {
    // 1️⃣ Try DB first
    final dbData = await getProductById(id);

    if (dbData != null) {
      return dbData; // ✅ already in DB
    }

    // 2️⃣ Insert JSON → DB
    await insertJsonToDB(); // 🔥 IMPORTANT

    // 3️⃣ Try again from DB
    final newData = await getProductById(id);

    if (newData != null) {
      return newData; // ✅ now found
    }

    print("❌ Product not found");
    return null;
  }
}