import 'package:flutter/material.dart';

class FoodItemCard extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final bool isVeg;
  final String tag = "abcd";

  const FoodItemCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.isVeg,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// LEFT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Veg Icon
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                      ),
                      child: const Center(
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                /// Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                /// Tag
                if (tag.isNotEmpty)
                  Row(
                    children: [
                      Container(
                        height: 6,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        tag,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                const SizedBox(height: 6),

                /// Price
                Text(
                  "${price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  )
                ),

                const SizedBox(height: 10),

                /// Icons Row

              ],
            ),
          ),

          const SizedBox(width: 10),

          /// RIGHT IMAGE + ADD BUTTON
          Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      image,
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// ADD BUTTON
                  Positioned(
                    bottom: -5,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "ADD +",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}