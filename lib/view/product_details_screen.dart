import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zomato_app/Utility/app_colors.dart';
import 'package:zomato_app/Widgets/quantity_box.dart';
import 'package:zomato_app/Widgets/rating_badge.dart';

import '../Widgets/app_circle_icon.dart';
import '../Widgets/horizontal_filter_bar.dart';
import '../Widgets/icon_text_chip.dart';
import '../Widgets/recommend_progressbar.dart';
import '../database/CartService.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, String> item;

  ProductDetailPage({super.key, required this.item});

  final List<Map<String, String>> products = [
    {
      "type": "Veg",
      "name": "Margherita Pizza",
      "price": "₹250",
      "desc": "Cheese, Tomato, Basil",
      "image": "assets/images/pizza.jpg",
      "restaurant_name": "Dominos",
    },
    {
      "type": "Non-Veg",
      "name": "Chicken Burger",
      "price": "₹180",
      "desc": "Grilled Chicken with Cheese",
      "image": "assets/images/burger.jpg",
      "restaurant_name": "MCD",
    },
    {
      "type": "Veg",
      "name": "French Fries",
      "price": "₹90",
      "desc": "Crispy Golden Fries",
      "image": "assets/images/fries.png",
      "restaurant_name": "Dominos's",
    },
  ];

  // Sample filter data
  final List<String> filters = ["Filters", "Highly Reordered", "Spicy"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(backgroundColor: Colors.white),
      body: Column(
        children: [
          /// 1. FLAT OFFER SECTION
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconTextChip(
                  icon: null,
                  image: "assets/images/leaf.png",
                  text: "Pure veg",
                  textColor: AppColors.darkGreen,
                  backgroundColor: Colors.green.shade50,
                ),

                // Restaurant name & Ratings
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item["title"] ?? "Product Detail",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingBadge(rating: "4.5"),
                  ],
                ),
                const SizedBox(height: 6),

                // Minutes & Nearby
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("Nearby", style: TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),

                Row(
                  children: const [
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("15-20 mins", style: TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 16),

                Divider(thickness: 0.5, color: Colors.grey.shade300),

                IconTextChip(
                  icon: null,
                  image: "assets/filters/discount.png",
                  text: "Flat 60 OFF above 290",
                  textColor: Colors.black,
                ),

                const SizedBox(height: 2),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// 2. FILTER SECTION (STICKY READY)
          Container(
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: HorizontalFilterBar(
              filters: filters,
              onTap: (index, value) {},
            ),
          ),

          const SizedBox(height: 2),

          /// 3. PRODUCT SECTION
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Recommended for you",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 2),

                  /// LIST (NO Expanded here)
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: products.length,
                      separatorBuilder: (_, __) =>  Divider(
                        color: Colors.grey.shade300,
                        thickness: 0.5,
                        height: 12,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Left: Veg/NonVeg and details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/veg.jpg",
                                      height: 15,
                                      width: 15,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product["name"]!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      product["desc"]!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    RecommendationProgressBar(progress:3,text: "Highly reordered"),
                                    const SizedBox(height: 4),
                                    Text(
                                      product["price"]!,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        AppCircleIcon(
                                          icon: Icons.bookmark_border,
                                          iconSize: 15,
                                          backgroundColor: Colors.grey.shade200,
                                          padding: 0,
                                        ),
                                        SizedBox(width: 10),
                                        AppCircleIcon(
                                          imagePath: "assets/images/share.png",iconSize: 15,
                                          backgroundColor: Colors.grey.shade200,
                                          padding: 0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Right: Image + Add button
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      product["image"]!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  /// QUANTITY BOX (half inside, half outside)
                                  Positioned(
                                    bottom: -12,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: QuantityBox(
                                        initialCount: 1,
                                        onChanged: (value) async {
                                          await CartService().addProduct(
                                            id: "1",
                                            name: product["name"]!,
                                            price: 300.0,
                                            restaurant: "Dominos",
                                            location: "Mumbai",
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
