import 'package:flutter/material.dart';
import 'package:zomato_app/Widgets/rating_badge.dart';

class RestaurantCard extends StatelessWidget {
  final String image;
  final String discount;
  final String name;
  final String rating;
  final String time;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.discount,
    required this.name,
    required this.rating,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124,
      margin: const EdgeInsets.only(right: 12, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image with overlays
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                ),
              ),

              /// Discount Label
              Positioned(
                top: 8,
                left: 0,
                child: Container(
                  padding:
                  const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    discount, // "50% OFF select items"
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              /// Rating Badge
              Positioned(
                bottom: 4,
                left: 4,
                child:RatingBadge(rating: '4.5')
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// Restaurant Name
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// Time
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}