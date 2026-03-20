import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zomato_app/Widgets/QuantityBox.dart';

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
      "image": "assets/images/pizza.png",
      "restaurant_name": "Dominos",
    },
    {
      "type": "Non-Veg",
      "name": "Chicken Burger",
      "price": "₹180",
      "desc": "Grilled Chicken with Cheese",
      "image": "assets/images/burger.png",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant name & Ratings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item["title"] ?? "Product Detail",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF083E11), // light background for the oval
                    borderRadius: BorderRadius.circular(20), // makes it oval
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // shrink to content
                    children: const [
                      Icon(Icons.star, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "4.5",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),

            // Minutes & Nearby
            Row(
              children: const [
                Icon(Icons.location_on, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text("Nearby"),
              ],
            ),

            Row(
              children: const [
                Icon(Icons.access_time, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text("15-20 mins"),
              ],
            ),
            const SizedBox(height: 12),

            // On time preparation, Melt Safe packing
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text("On time Preparation"),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // // 5 - Filters Veg / Non-Veg
            // Row(
            //   children: [
            //     FilterChip(
            //       label: const Text("Veg"),
            //       selected: true,
            //       onSelected: (val) {},
            //       backgroundColor: Colors.green[100],
            //       selectedColor: Colors.green[300],
            //     ),
            //     const SizedBox(width: 8),
            //     FilterChip(
            //       label: const Text("Non-Veg"),
            //       selected: true,
            //       onSelected: (val) {},
            //       backgroundColor: Colors.red[100],
            //       selectedColor: Colors.red[300],
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 16),

            // 6 - Recommended for you
            const Text(
              "Recommended for you",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Row 7 - Product List
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
                separatorBuilder: (_, __) => const Divider(
                  color: Colors.grey,
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
                            Text(
                              product["type"]!,
                              style: TextStyle(
                                  color: product["type"] == "Veg"
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product["name"]!,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              product["desc"]!,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product["price"]!,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      // Right: Image + Add button
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  product["image"]!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain, // use cover to fill nicely
                                ),
                              ),
                              Positioned(
                                bottom: 4, // a little padding from bottom
                                child: QuantityBox(
                                  initialCount: 1,
                                  onChanged: (value) async {
                                    await CartService().addProduct(
                                      id:"1",
                                      name: product["name"]!,
                                      price: 300.0,
                                      restaurant:  "Dominos",
                                      location: "Mumbai",
                                    );
                                    },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}