import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/location.dart';
import '../../model/restaurant.dart';
import '../../model/user.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }

    _database = await _initDB('food.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {

    // location Table
    await db.execute('''
   CREATE TABLE location(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  latitude REAL,
  longitude REAL,
  address TEXT,
  area TEXT,
  city TEXT,
  FOREIGN KEY (user_id) REFERENCES user(id)
)''');

    // Categories Table
    await db.execute('''
    CREATE TABLE categories(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    image TEXT,
    is_veg INTEGER
    )''');

    // Restaurant Table
    await db.execute('''
      CREATE TABLE restaurants(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        image TEXT,
        time TEXT,
        price REAL,
        discount_price TEXT,
        category TEXT
        )''');

    // Menu Table
    await db.execute('''
      CREATE TABLE food(
  id INTEGER PRIMARY KEY,
  restaurant_id INTEGER,
  name TEXT,
  description TEXT,
  price REAL,
  image TEXT,
  type TEXT
)''');

    // Review Table
    await db.execute('''
    CREATE TABLE review(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    restaurant_id INTEGER,
    user_name TEXT,
    rating REAL,
    comment TEXT,
    created_at TEXT
    )''');

    // Wishlist Table
    await db.execute('''
    CREATE TABLE wishlist(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    restaurant_id INTEGER,
    created_at TEXT
    )''');

    /// 🟢 Restaurant Table
    await db.execute('''
    CREATE TABLE restaurant_detail(
      id INTEGER PRIMARY KEY,
      name TEXT,
      location TEXT
    )
  ''');

    /// 🟢 Food Table
    await db.execute('''
    CREATE TABLE foods(
      id INTEGER PRIMARY KEY,
      title TEXT,
      image TEXT,
      time TEXT,
      discount TEXT,
      category TEXT,
      price REAL,
      restaurant_id INTEGER
    )
  ''');


  }

  Future<int> insertLocation(UserLocation location) async {
    final db = await DBHelper.instance.database;

    return await db.insert(
      'location',
      location.toMap(),
    );
  }


  Future<Restaurant?> getProductById(int id) async {
    final db = await DBHelper.instance.database;

    final result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    // If found in DB
    if (result.isNotEmpty) {
      return Restaurant.fromMap(result.first);
    }

    // Else fetch from API
    final apiData = await fetchRestaurants();

    if (apiData.isEmpty) return null;

    // Find specific product
    try {
      return apiData.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Restaurant>> getFoodByRestaurant(int restaurantId) async {
    final db = await DBHelper.instance.database;

    final result = await db.query(
      'food',
      where: 'restaurant_id = ?',
      whereArgs: [restaurantId],
    );

    return result.map((e) => Restaurant.fromMap(e)).toList();
  }

  Future<List<Restaurant>> fetchRestaurants() async {
    final String response =
    await rootBundle.loadString('assets/json_data/restaurants.json');

    final List data = json.decode(response);

    return data.map((e) => Restaurant.fromMap(e)).toList();
  }
}
