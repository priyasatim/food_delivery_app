import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;

  CartService._internal();

  static const String _cartKey = "cart";

  SharedPreferences? _prefs;

  /// 🔥 Initialize once (call in main)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> addProduct({
    required String id,
    required String name,
    required double price,
    required String restaurant,
    required String location,
  }) async {
    List<String> cart = _prefs?.getStringList(_cartKey) ?? [];

    Map<String, dynamic> product = {
      "id": id,
      "name": name,
      "price": price,
      "restaurant": restaurant,
      "location": location,
    };

    cart.add(jsonEncode(product)); // 🔥 convert to string

    await _prefs?.setStringList(_cartKey, cart);
  }

  /// ➖ Remove product
  int getProductCount(String productId) {
    List<String> cart = _prefs?.getStringList(_cartKey) ?? [];

    return cart.where((item) {
      final decoded = jsonDecode(item);
      return decoded["id"] == productId;
    }).length;
  }

  /// 🔢 Get count of specific product
  List<Map<String, dynamic>> getCartItems() {
    List<String> cart = _prefs?.getStringList(_cartKey) ?? [];

    return cart.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }

  Future<void> removeProduct(String productId) async {
    List<String> cart = _prefs?.getStringList(_cartKey) ?? [];

    cart.removeWhere((item) {
      final decoded = jsonDecode(item);
      return decoded["id"] == productId;
    });

    await _prefs?.setStringList(_cartKey, cart);
  }

  /// 🛒 Total count
  int getTotalCount() {
    List<String> cart = _prefs?.getStringList(_cartKey) ?? [];

    return cart.length;
  }

  /// 🧹 Clear cart
  Future<void> clearCart() async {
    await _prefs?.remove(_cartKey);
  }
}