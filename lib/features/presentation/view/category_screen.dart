
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends SliverPersistentHeaderDelegate {
  final List<Map<String, String>> categories;
  final int selectedIndex = 0;

  CategoryScreen(this.categories);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Color(0xFFF8F8F8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            width: 80,
            margin: EdgeInsets.only(right: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(cat["image"]!, width: 46, height: 46),
                const SizedBox(height: 2),
                Text(
                  cat["name"]!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                // Line below category
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? Colors.orange: Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}