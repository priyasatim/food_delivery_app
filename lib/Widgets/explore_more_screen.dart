import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreMoreScreen extends SliverPersistentHeaderDelegate {
  final List<Map<String, String>> explore;

  ExploreMoreScreen(this.explore);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: explore.length,
        itemBuilder: (context, index) {
          final cat = explore[index];
          return Container(
            width: 100,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(cat["image"]!, width: 40, height: 40),
                SizedBox(height: 4),
                Text(
                  cat["title"]!,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}